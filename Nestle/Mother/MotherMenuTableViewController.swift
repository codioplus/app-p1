//
//  MotherMenuTableViewController.swift
//  Nestle
//
//  Created by User on 5/15/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class MotherMenuTableViewController: UITableViewController {


    
    
    var accounttype : String?
    
    @IBOutlet weak var home: UILabel!
    @IBOutlet weak var profile: UILabel!
    @IBOutlet weak var notifications: UILabel!
    @IBOutlet weak var doctorNot: UILabel!
    @IBOutlet weak var favourite2: UILabel!
    @IBOutlet weak var dashboard: UILabel!
    @IBOutlet weak var myprofile2: UILabel!
    @IBOutlet weak var home2: UILabel!
    @IBOutlet weak var favourite: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accounttype = KeychainWrapper.standard.string(forKey: "accounttype")!
        print("______\(accounttype ?? "66666666")______")
        self.home.text = ("Home").localiz()
        self.profile.text  = ("My_Profile").localiz()
        self.notifications.text  = ("Notifications").localiz()
        self.doctorNot.text  = ("Doctor_Notifications").localiz()
        self.favourite2.text  = ("Favourite").localiz()
        self.dashboard.text  = ("Dashboard").localiz()
        self.myprofile2.text  = ("My_Profile").localiz()
        self.home2.text  = ("Home").localiz()
        self.favourite.text  = ("Favourite").localiz()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
       // let indexPath = IndexPath(item: 0, section: 1)
      //  tableView.deselectRow(at: indexPath, animated: false)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if accounttype == "5"{
        return 4
        }else{
        return 5
        }
        
    }

    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if accounttype == "5"{
        if indexPath.row == 0{
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "HomeTableViewController") as! HomeTableViewController
            if let kid_uid = UserDefaults.standard.string(forKey: "kid_uid") {
                Dvc.child_id = kid_uid
                if let kid_name = UserDefaults.standard.string(forKey: "kid_name") {
                    Dvc.child_name = kid_name
                }
                if let kid_age = UserDefaults.standard.string(forKey: "kid_age") {
                    Dvc.child_age = kid_age
                }
            }
            self.navigationController?.pushViewController(Dvc, animated: true)
        }
        
        
        if indexPath.row == 1{
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.navigationController?.pushViewController(Dvc, animated: true)
         
        }
        
        
        
        if indexPath.row == 2{
            
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
            self.navigationController?.pushViewController(Dvc, animated: true)
            
            
        }
        
        
        if indexPath.row == 3{
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "MotherMilestoneUIViewController") as! MotherMilestoneUIViewController
            Dvc.type = "favourite"
            Dvc.type_id = 0
            Dvc.child_id = ""
            Dvc.child_age = "2014-01-01"
            Dvc.child_name = ""
            self.navigationController?.pushViewController(Dvc, animated: true)
        }
        
        
//        if indexPath.row == 4{
//        return
//        }
            
            
            
            
            
            
            
            
    }else{
            
            
            
            
            
            
            
            if indexPath.row == 0{
                let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                let Dvc = Storyboard.instantiateViewController(withIdentifier: "HomeDoctorViewController") as! HomeDoctorViewController
                self.navigationController?.pushViewController(Dvc, animated: true)
            }
            
            
            if indexPath.row == 1{
                let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                let Dvc = Storyboard.instantiateViewController(withIdentifier: "ProfileDoctorViewController") as! ProfileDoctorViewController
                self.navigationController?.pushViewController(Dvc, animated: true)
                return
            }
            
            
            
            if indexPath.row == 2{
                let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                let Dvc = Storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
                self.navigationController?.pushViewController(Dvc, animated: true)
            }
            
            
            if indexPath.row == 3{
                let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                let Dvc = Storyboard.instantiateViewController(withIdentifier: "MotherMilestoneUIViewController") as! MotherMilestoneUIViewController
                Dvc.type = "favourite"
                Dvc.type_id = 0
                Dvc.child_id = ""
                Dvc.child_age = "2014-01-01"
                Dvc.child_name = ""
                self.navigationController?.pushViewController(Dvc, animated: true)
            }
            
            
               if indexPath.row == 4{
                let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                let Dvc = Storyboard.instantiateViewController(withIdentifier: "ShoutoutViewController") as! ShoutoutViewController
                self.navigationController?.pushViewController(Dvc, animated: true)
               }
            
            
            
        }
        
        
    }
    
    
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
print(indexPath)
        if accounttype == "5"{

               return super.tableView(tableView , cellForRowAt: indexPath)

        }else{
       // return super.tableView(tableView , cellForRowAt: indexPath)
            return super.tableView(tableView , cellForRowAt: IndexPath(row: indexPath.row + 4, section: 0))

        }
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
