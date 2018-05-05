//
//  KidsTableViewController.swift
//  
//
//  Created by User on 4/19/18.
//

import UIKit
import SideMenu
import Alamofire

class KidsTableViewController: UITableViewController {
let functions = Functions()
var kids = [Kids]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       functions.menuRight(controller: self)
        
        let URL_GET_DATA = functions.apiLink()+"get_mom_kids.json/59"
        
        Alamofire.request(URL_GET_DATA).responseJSON { response in
            
            //getting json
            if let json = response.result.value {
                
                //converting json to NSArray
                let kidsArray : NSArray  = json as! NSArray
                
                //traversing through all elements of the array
                for i in 0..<kidsArray.count{
                    
                    //adding hero values to the hero list
                    self.kids.append(Kids(
                        title: (kidsArray[i] as AnyObject).value(forKey: "title") as? String,
                         dob: (kidsArray[i] as AnyObject).value(forKey: "dob") as? String,
                         profile_image: (kidsArray[i] as AnyObject).value(forKey: "profile_image") as? String,
                        child_id: (kidsArray[i] as AnyObject).value(forKey: "child_id") as? Int
                       
                    ))
                    
                }

                self.tableView.reloadData()
            }
            
        }
        
           self.tableView.reloadData()
        
      //  self.tableViewHeroes.reloadData()
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return kids.count
    }

    

    @IBAction func openRightMenu(_ sender: UIBarButtonItem) {
        
        present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)

    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kids", for: indexPath) as! KidsTableViewCell
        let kid : Kids = kids[indexPath.row]
        print(kid.dob)
        if let imageUrlString = kid.profile_image{
        
        if let imageUrl = URL(string: imageUrlString){
        do{
        let imageData = try! Data(contentsOf: imageUrl)
        cell.kidImage.image = UIImage(data: imageData)
        }catch let err{
            
            print("Error  : \(err)")
            }
        }
        }
        
    else{
    
          cell.kidImage.image = UIImage(named: "no_profile.png")
            
        }
        cell.kidName.text = kid.title
        if let dob = kid.dob{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd" //Your date format
            
            let dateFormat = dateFormatter.date(from: dob)
            if dateFormat != nil{
   
               // let dateCurrent = Date()
       
                let formatedStartDate = dateFormatter.date(from: dob)
                let currentDate = Date()
              
                let components = Set<Calendar.Component>([.second, .minute, .hour, .day, .month, .year])
                //components.timeZone = TimeZone.current
                let differenceOfDate = Calendar.current.dateComponents(components, from: formatedStartDate!, to: currentDate)
                
                print (differenceOfDate)
                

                
                let months = differenceOfDate.month
                if months == 1{
                    cell.kidAge.text = "\(months ?? 0) month"
                }else{
                    
                cell.kidAge.text = "\(months ?? 0) months"
                }
            }
            
            
            
            
        }else{
             cell.kidAge.text = "ii"
        }
        return cell
    }
  

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "HomeTableViewController") as! HomeTableViewController
        
        self.navigationController?.pushViewController(Dvc, animated: true)
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
