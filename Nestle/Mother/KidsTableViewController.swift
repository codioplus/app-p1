//
//  KidsTableViewController.swift
//  
//
//  Created by User on 4/19/18.
//

import UIKit
import SideMenu
import Alamofire
import SwiftKeychainWrapper
import Kingfisher

class KidsTableViewController: UITableViewController {
let functions = Functions()
var kids = [Kids]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ("you_kids").localiz()
     functions.menuRight(controller: self)
        let momId : String? = KeychainWrapper.standard.string(forKey: "uid")
        let URL_GET_DATA = functions.apiLink()+"get_mom_kids.json/"+momId!
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
                         child_id: (kidsArray[i] as AnyObject).value(forKey: "child_id") as? String,
                         gender: (kidsArray[i] as AnyObject).value(forKey: "gender") as? String
                        
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
        
        if functions.lang() == "ar"{
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        }else{
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        }

    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kids", for: indexPath) as! KidsTableViewCell
        let kid : Kids = kids[indexPath.row]
     //   print(kid.dob)
        
      
        
        
        if let imageUrlString = kid.profile_image{
        
        if let imageUrl = URL(string: imageUrlString){
        do{
            
           cell.kidImage.kf.setImage(with: imageUrl)
            
            
//        let imageData = try! Data(contentsOf: imageUrl)
//        cell.kidImage.image = UIImage(data: imageData)
        }
        }
        }
        
    else{
    
          cell.kidImage.image = UIImage(named: "no_profile.png")
            
        }
        cell.kidName.text = kid.title
        if let dob = kid.dob{
            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-mm-dd"
//
//            let dateFormat = dateFormatter.date(from: dob)
//            if dateFormat != nil{
//
//
//
//                let formatedStartDate = dateFormatter.date(from: dob)
//                let currentDate = Date()
//
//                let components = Set<Calendar.Component>([.second, .minute, .hour, .day, .month, .year])
//
//                let differenceOfDate = Calendar.current.dateComponents(components, from: formatedStartDate!, to: currentDate)
//
//                print (differenceOfDate)
//
//
//
//                let months = differenceOfDate.month
//                if months == 1{
//                    cell.kidAge.text = "\(months ?? 0) \(NSLocalizedString("month", comment: "month")))"
//                }else{
//
//                cell.kidAge.text = "\(months ?? 0) \(NSLocalizedString("months", comment: "months"))"
//                }
//            }
//
//
     
            
            if kid.gender == "female"{
                
                cell.kidImage.layer.borderColor =  #colorLiteral(red: 0.9607843137, green: 0.4784313725, blue: 0.5098039216, alpha: 1)
            }else{
                cell.kidImage.layer.borderColor = #colorLiteral(red: 0.3647058824, green: 0.7098039216, blue: 0.6431372549, alpha: 1)
            }
            
            
            
            
            let strDOB = dob
            
            let ageComponents = strDOB.components(separatedBy: "-")
            
            let dateDOB = Calendar.current.date(from: DateComponents(year:
                Int(ageComponents[0]), month: Int(ageComponents[1]), day:
                Int(ageComponents[2])))!
            
            
            let myAge = dateDOB.age
            
               if myAge == 1{
                 cell.kidAge.text = "\(myAge) \(("month").localiz())"
                 }else{
                cell.kidAge.text = "\(myAge)  \(("months").localiz())"
             }
            //print(myAge)
           // //print(Double(myAge))
           // print(myAge)
            
            
            
        }else{
         
        }
        return cell
    }
  

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let kid : Kids = kids[indexPath.row]
        
        //print(kids[indexPath.row].child_id)
       
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "HomeTableViewController") as! HomeTableViewController
        Dvc.child_id = kids[indexPath.row].child_id!
        Dvc.child_name = kids[indexPath.row].title!
        Dvc.child_age = kids[indexPath.row].dob!
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



