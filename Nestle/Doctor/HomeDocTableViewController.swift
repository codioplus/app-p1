//
//  HomeDocTableViewController.swift
//  Nestle
//
//  Created by User on 5/28/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit

class HomeDocTableViewController: UITableViewController {

        @IBOutlet weak var DparentBigView: UIView!
        @IBOutlet weak var DfeedingBigView: UIView!
    
        @IBOutlet weak var DmilestoneMainLabel: UILabel!
        @IBOutlet weak var DmilestoneDescLabel: UILabel!
        @IBOutlet weak var DtipsFor1: UILabel!
        @IBOutlet weak var DtipsFor2: UILabel!
        @IBOutlet weak var DparentTips: UILabel!
        @IBOutlet weak var DfeedingTips: UILabel!
        @IBOutlet weak var DBrainMainLabel: UILabel!
        @IBOutlet weak var DBrainDescLabel: UILabel!
        @IBOutlet weak var DvaccinationMainLabel: UILabel!
        @IBOutlet weak var DvaccinationDescLabel: UILabel!
        @IBOutlet weak var DgrowthMainLabel: UILabel!
        @IBOutlet weak var DvideosMainLabel: UILabel!
    
        @IBOutlet weak var registedMothersLabel: UILabel!
         var functions = Functions()
 
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if functions.lang() == "ar"{
            DmilestoneMainLabel.font = UIFont(name: "Tahoma-Bold", size: 21.0)
            DtipsFor1.font = UIFont(name: "Tahoma-Bold", size: 21.0)
            DtipsFor2.font = UIFont(name: "Tahoma-Bold", size: 21.0)
            DparentTips.font = UIFont(name: "Tahoma-Bold", size: 21.0)
            DfeedingTips.font = UIFont(name: "Tahoma-Bold", size: 21.0)
            DBrainMainLabel.font = UIFont(name: "Tahoma-Bold", size: 23.0)
            DvaccinationMainLabel.font = UIFont(name: "Tahoma-Bold", size: 21.0)
            DgrowthMainLabel.font = UIFont(name: "Tahoma-Bold", size: 21.0)
            DvideosMainLabel.font = UIFont(name: "Tahoma-Bold", size: 21.0)
            registedMothersLabel.font = UIFont(name: "Tahoma-Bold", size: 21.0)
        }
        
        
        
        
        

        
               self.DmilestoneMainLabel.text = ("milestoneMainLabel").localiz()
               self.DmilestoneDescLabel.text = ("milestoneDescLabel").localiz()
        
                self.DvaccinationMainLabel.text = ("vaccinationMainLabel").localiz()
                self.DvaccinationDescLabel.text = ("vaccinationDescLabel").localiz()
        
                self.DBrainMainLabel.text = ("BrainMainLabel").localiz()
                self.DBrainDescLabel.text = ("BrainDescLabel").localiz()
                self.DgrowthMainLabel.text = ("growthMainLabel").localiz()
                self.DvideosMainLabel.text = ("videosMainLabel").localiz()
        
                self.DtipsFor1.text = ("tipsFor1").localiz()
                self.DtipsFor2.text = ("tipsFor2").localiz()
                self.DparentTips.text = ("parentTips").localiz()
                self.DfeedingTips.text = ("feedingTips").localiz()
                self.registedMothersLabel.text = ("registedMothersLabel").localiz()
        
                let tapGestureView1 = UITapGestureRecognizer(target: self, action: #selector(self.tapOneAct1))
                let tapGestureView2 = UITapGestureRecognizer(target: self, action: #selector(self.tapOneAct2))
                //add gesture into both Views.
                self.DparentBigView.addGestureRecognizer(tapGestureView1)
                self.DfeedingBigView.addGestureRecognizer(tapGestureView2)
        
        
        
        
        
        
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
        return 8
    }

  
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.row == 0{
            
            let alert = UIAlertController(title: ("Alert").localiz(), message: ("redirect_to").localiz()+"https://me.wyethnutritionsc.org", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: ("OK").localiz(), style: UIAlertActionStyle.default,
                                          handler: { (action:UIAlertAction!) -> Void in
                                           UIApplication.shared.open(URL(string: "https://me.wyethnutritionsc.org")!, options: [:], completionHandler: nil)
                                           
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                             self.dismiss(animated: true, completion: nil)
                                   
                                            }
                         
            }))
            
            
            alert.addAction(UIAlertAction(title: ("cancel").localiz(), style: UIAlertActionStyle.cancel,
                                              handler: { (action:UIAlertAction!) -> Void in
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                self.dismiss(animated: true, completion: nil)
                                                
                                            } }))
            
            
            
            
               self.present(alert, animated: true, completion: nil)
  


        }
        
        
        if indexPath.row == 1{
            
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "RegistedViewController") as! RegistedViewController
            self.navigationController?.pushViewController(Dvc, animated: true)
            
        }
        
        
        if indexPath.row == 2{
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "MotherMilestoneUIViewController") as! MotherMilestoneUIViewController
            Dvc.type = "milestone"
            Dvc.type_id = 0
            
            Dvc.child_id = "0"
            Dvc.child_age = "2014-01-01"
            Dvc.child_name = "Doctor"
            self.navigationController?.pushViewController(Dvc, animated: true)
        }
        
        
        if indexPath.row == 3{
            
                        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let Dvc = Storyboard.instantiateViewController(withIdentifier: "VaccinationViewController") as! VaccinationViewController
                                    Dvc.type = "vaccine"
                                    Dvc.type_id = 3
                                    Dvc.child_id = "1"
                                    Dvc.child_age = "2014-01-01"
                                    Dvc.child_name = "Doctor"
                        self.navigationController?.pushViewController(Dvc, animated: true)
        }
        
        
        

        
        
        if indexPath.row == 5{
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "MotherMilestoneUIViewController") as! MotherMilestoneUIViewController
            Dvc.type = "brain"
            Dvc.type_id = 3
            Dvc.child_id = "0"
            Dvc.child_age = "2014-01-01"
            Dvc.child_name = "Doctor"
            self.navigationController?.pushViewController(Dvc, animated: true)
        }
        
        if indexPath.row == 6{
            
//            let alert2 = UIAlertController(title: ("Alert").localiz(), message: ("coming_soon").localiz(), preferredStyle: .alert)
//
//            alert2.addAction(UIAlertAction(title: ("OK").localiz(), style: UIAlertActionStyle.default,
//                                           handler: { (action:UIAlertAction!) -> Void in
//
//                                            self.dismiss(animated: true, completion: nil)
//
//
//
//            }))
//
//
//            self.present(alert2, animated: true, completion: nil)
            
            
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "GrowthChartViewController") as! GrowthChartViewController
          
            self.navigationController?.pushViewController(Dvc, animated: true)
            
            
            
            
        }
        
        
        
        
        if indexPath.row == 7{
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "MotherMilestoneUIViewController") as! MotherMilestoneUIViewController
            Dvc.type = "video"
            Dvc.type_id = 1
            Dvc.child_id = "0"
            Dvc.child_age = "2014-01-01"
            Dvc.child_name = "Doctor"
            self.navigationController?.pushViewController(Dvc, animated: true)
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    @objc func tapOneAct1(sender: UITapGestureRecognizer){
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "MotherMilestoneUIViewController") as! MotherMilestoneUIViewController
        Dvc.type = "parent"
        Dvc.type_id = 2
        Dvc.child_id = "0"
        Dvc.child_age = "2014-01-01"
        Dvc.child_name = "Doctor"
        self.navigationController?.pushViewController(Dvc, animated: true)
        
    }
    
    
    @objc func tapOneAct2(sender: UITapGestureRecognizer){
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "MotherMilestoneUIViewController") as! MotherMilestoneUIViewController
        Dvc.type = "feeding"
        Dvc.type_id = 1
        Dvc.child_id = "0"
        Dvc.child_age = "2014-01-01"
        Dvc.child_name = "Doctor"
        self.navigationController?.pushViewController(Dvc, animated: true)
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            
            return 220
            
        }
        
        if indexPath.row == 4{
            
            return 180
            
        }
        
        
        return UITableViewAutomaticDimension
    }
    
    


}
