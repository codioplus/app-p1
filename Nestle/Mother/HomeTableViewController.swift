//
//  HomeTableViewController.swift
//  Nestle
//
//  Created by User on 3/2/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import JGProgressHUD
class HomeTableViewController: UITableViewController {

    let functions = Functions()
    
    @IBOutlet weak var parentBigView: UIView!
    @IBOutlet weak var feedingBigView: UIView!
    
    @IBOutlet weak var milestoneMainLabel: UILabel!
    @IBOutlet weak var milestoneDescLabel: UILabel!
    @IBOutlet weak var tipsFor1: UILabel!
    @IBOutlet weak var tipsFor2: UILabel!
    @IBOutlet weak var parentTips: UILabel!
    @IBOutlet weak var feedingTips: UILabel!
    @IBOutlet weak var BrainMainLabel: UILabel!
    @IBOutlet weak var BrainDescLabel: UILabel!
    @IBOutlet weak var vaccinationMainLabel: UILabel!
    @IBOutlet weak var vaccinationDescLabel: UILabel!
    @IBOutlet weak var growthMainLabel: UILabel!
    @IBOutlet weak var videosMainLabel: UILabel!
    var child_id:String = ""
    var child_age:String = ""
    var child_name:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
     
        if functions.lang() == "ar"{
        
        milestoneMainLabel.font = UIFont(name: "Tahoma-Bold", size: 21.0)

    tipsFor1.font = UIFont(name: "Tahoma-Bold", size: 21.0)
    tipsFor2.font = UIFont(name: "Tahoma-Bold", size: 21.0)
        parentTips.font = UIFont(name: "Tahoma-Bold", size: 21.0)
      feedingTips.font = UIFont(name: "Tahoma-Bold", size: 21.0)
        BrainMainLabel.font = UIFont(name: "Tahoma-Bold", size: 21.0)
      
       vaccinationMainLabel.font = UIFont(name: "Tahoma-Bold", size: 21.0)

        growthMainLabel.font = UIFont(name: "Tahoma-Bold", size: 21.0)
        videosMainLabel.font = UIFont(name: "Tahoma-Bold", size: 21.0)
        }
        
        
        
        
        self.milestoneMainLabel.text = ("milestoneMainLabel").localiz()
        self.milestoneDescLabel.text = ("milestoneDescLabel").localiz()
        
        self.vaccinationMainLabel.text = ("vaccinationMainLabel").localiz()
        self.vaccinationDescLabel.text = ("vaccinationDescLabel").localiz()
        
        self.BrainMainLabel.text = ("BrainMainLabel").localiz()
        self.BrainDescLabel.text = ("BrainDescLabel").localiz()
        self.growthMainLabel.text = ("growthMainLabel").localiz()
        self.videosMainLabel.text = ("videosMainLabel").localiz()
        
        self.tipsFor1.text = ("tipsFor1").localiz()
        self.tipsFor2.text = ("tipsFor2").localiz()
        self.parentTips.text = ("parentTips").localiz()
        self.feedingTips.text = ("feedingTips").localiz()
        
        
        let tapGestureView1 = UITapGestureRecognizer(target: self, action: #selector(self.tapOneAct1))
        let tapGestureView2 = UITapGestureRecognizer(target: self, action: #selector(self.tapOneAct2))
        //add gesture into both Views.
        self.parentBigView.addGestureRecognizer(tapGestureView1)
        self.feedingBigView.addGestureRecognizer(tapGestureView2)
        
        
        
        functions.menuRight(controller: self)
        
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    
super.viewWillAppear(false)
    

    
      let momId : String? = KeychainWrapper.standard.string(forKey: "uid")
    
    
    
    
    if self.child_id != "" {
        
        print("empty")
        print(self.child_id )
             print("empty")
        UserDefaults.standard.set(self.child_id, forKey: "kid_uid")
        UserDefaults.standard.set(self.child_name, forKey: "kid_name")
        UserDefaults.standard.set(self.child_age, forKey: "kid_age")
        self.title = self.child_name.uppercased()
        
        
    }else{
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = ("loading").localiz()
        hud.show(in:self.view)
        let URL_GET_DATA = functions.apiLink()+"get_mom_kids.json/"+momId!

            Alamofire.request(URL_GET_DATA).responseJSON { response in
                                if let json = response.result.value {
                                let val = JSON(json)
     
                     
                       
                                    if val.count > 0 {
                                    
                                 //   print("Abooo")
                               //     print(val)
                                //      print("Abooo")
                                
                                    self.child_id = val[0]["child_id"].string!
                                    self.child_name = val[0]["title"].string!
                                    self.child_age = val[0]["dob"].string!
             

                            UserDefaults.standard.set(self.child_id, forKey: "kid_uid")
                            UserDefaults.standard.set(self.child_name, forKey: "kid_name")
                            UserDefaults.standard.set(self.child_age, forKey: "kid_age")
                                        
                                     
                                     //   print("yyyyy")
                                     //   print(self.child_id)
                                     //   print("yyyyy")
                                        
                                        
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)){
                                            self.title = self.child_name.uppercased()
                                            
                                       
                                        

                                        
                                        
                                         }
                                        
                                        
                                        
                                      hud.dismiss(afterDelay:0.5)
                                        
                                        
                                        
                                    }else{
                                         hud.dismiss(afterDelay:0)
                                        let alert3 = UIAlertController(title: ("Alert").localiz(), message: ("nokids").localiz(), preferredStyle: .alert)
                                        
                                        alert3.addAction(UIAlertAction(title: ("OK").localiz(), style: UIAlertActionStyle.default,
                                                                       handler: { (action:UIAlertAction!) -> Void in
                                        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        let Dvc = Storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                                        
                                        self.navigationController?.pushViewController(Dvc, animated: true)
                                          }))
                                           self.present(alert3, animated: true, completion: nil)
                                    }
                                    
                                    
                                    
  
                        }else{
                                     hud.dismiss(afterDelay:0)
                                    let alert3 = UIAlertController(title: ("Alert").localiz(), message: ("nokids").localiz(), preferredStyle: .alert)
                                    
                                    alert3.addAction(UIAlertAction(title: ("OK").localiz(), style: UIAlertActionStyle.default,
                                                                   handler: { (action:UIAlertAction!) -> Void in
                                                                    
                                                                    let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                                    let Dvc = Storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                                                                    
                                                                    self.navigationController?.pushViewController(Dvc, animated: true)
                                                                    
                                                                    
                                                                    
                                    }))
                                    
                                       self.present(alert3, animated: true, completion: nil)

        
                        }
        
                    }
        
    }



  

    
    
    
}
@objc func tapOneAct1(sender: UITapGestureRecognizer){
    
    let Storyboard = UIStoryboard(name: "Main", bundle: nil)
    let Dvc = Storyboard.instantiateViewController(withIdentifier: "MotherMilestoneUIViewController") as! MotherMilestoneUIViewController
    Dvc.type = "parent"
    Dvc.type_id = 2
    Dvc.child_id = child_id
    Dvc.child_age = child_age
    Dvc.child_name = child_name
    self.navigationController?.pushViewController(Dvc, animated: true)
        
    }
    
    
    @objc func tapOneAct2(sender: UITapGestureRecognizer){
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "MotherMilestoneUIViewController") as! MotherMilestoneUIViewController
        Dvc.type = "feeding"
        Dvc.type_id = 1
        Dvc.child_id = child_id
        Dvc.child_age = child_age
        Dvc.child_name = child_name
        self.navigationController?.pushViewController(Dvc, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if indexPath.row == 0{
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "MotherMilestoneUIViewController") as! MotherMilestoneUIViewController
                Dvc.type = "milestone"
                Dvc.type_id = 0

                Dvc.child_id = child_id
                Dvc.child_age = child_age
                Dvc.child_name = child_name
            self.navigationController?.pushViewController(Dvc, animated: true)
        }
        
        
        if indexPath.row == 1{
            
//            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let Dvc = Storyboard.instantiateViewController(withIdentifier: "VaccinationViewController") as! VaccinationViewController
//                        Dvc.type = "vaccine"
//                        Dvc.type_id = 3
//                        Dvc.child_id = child_id
//                        Dvc.child_age = child_age
//                        Dvc.child_name = child_name
//            self.navigationController?.pushViewController(Dvc, animated: true)
        }
        
        

        if indexPath.row == 2{
           
         return
            
        }
        
        
        if indexPath.row == 3{
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "MotherMilestoneUIViewController") as! MotherMilestoneUIViewController
            Dvc.type = "brain"
            Dvc.type_id = 3
            Dvc.child_id = child_id
            Dvc.child_age = child_age
            Dvc.child_name = child_name
            self.navigationController?.pushViewController(Dvc, animated: true)
        }
        
        
        if indexPath.row == 4{
//
//        let alert2 = UIAlertController(title: ("Alert").localiz(), message: ("coming_soon").localiz(), preferredStyle: .alert)
//
//        alert2.addAction(UIAlertAction(title: ("OK").localiz(), style: UIAlertActionStyle.default,
//                                       handler: { (action:UIAlertAction!) -> Void in
//
//                                        self.dismiss(animated: true, completion: nil)
//
//
//
//        }))
//
//
//        self.present(alert2, animated: true, completion: nil)
            
            
            
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "GrowthChartViewController") as! GrowthChartViewController
//            Dvc.type = "brain"
//            Dvc.type_id = 3
//            Dvc.child_id = child_id
//            Dvc.child_age = child_age
//            Dvc.child_name = child_name
            self.navigationController?.pushViewController(Dvc, animated: true)
        
        }
        
        if indexPath.row == 5{
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "MotherMilestoneUIViewController") as! MotherMilestoneUIViewController
            Dvc.type = "video"
            Dvc.type_id = 1
            Dvc.child_id = child_id
            Dvc.child_age = child_age
            Dvc.child_name = child_name
            self.navigationController?.pushViewController(Dvc, animated: true)
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func openRightMenu(_ sender: UIBarButtonItem) {

        if self.functions.lang() == "ar"{
  
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        
        }else{
           
        present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
      
        
    }
    }
    
    @IBAction func kidsList(_ sender: UIBarButtonItem) {
        
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "KidsTableViewController") as! KidsTableViewController

        self.navigationController?.pushViewController(Dvc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
            let Dvc = segue.destination as! VaccinationViewController
                                    Dvc.type = "vaccine"
                                    Dvc.type_id = 3
                                    Dvc.child_id = child_id
                                    Dvc.child_age = child_age
                                    Dvc.child_name = child_name
           
        
    }
    
}
