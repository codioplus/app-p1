//
//  VaccinationViewController.swift
//  Nestle
//
//  Created by User on 5/10/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import Kingfisher
import JGProgressHUD

class VaccinationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var yellowLine: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var type = String()
    var type_id = Int()
    var child_id = String()
    var child_age = String()
    var child_name = String()
    let accounttype = KeychainWrapper.standard.string(forKey: "accounttype")!

    
    let functions = Functions()

    var momId = String()
    var countryId = String()
    var vaccine = [Vaccine]()
 
    var dataAry = [Vaccine]()
    
    var usedData = [Vaccine]()
    
    
        @IBOutlet weak var filterYears: UISegmentedControl!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedData.count
    }
    
    @objc func tapInfo(_ sender: Any) {
        let dat : Vaccine = usedData[(sender as AnyObject).tag]

        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "VaccineInfoViewController") as! VaccineInfoViewController
        if self.functions.lang() == "ar"{
       // Dvc.bodyVac = dat.arabic_body
       // Dvc.titleVac = dat.arabic_name
            UserDefaults.standard.set(dat.arabic_name, forKey: "titleVac")
            UserDefaults.standard.set(dat.arabic_body, forKey: "bodyVac")
        }
        
        else{
            UserDefaults.standard.set(dat.title, forKey: "titleVac")
            UserDefaults.standard.set(dat.body, forKey: "bodyVac")
          //  Dvc.bodyVac = dat.body
          //  Dvc.titleVac = dat.title
        }
        
        self.navigationController?.popToViewController(Dvc, animated: true)
        
        
    }
    
    
    @objc func tapLock(_ sender : MyTapGesture) {
   
     sender.cell.tapText.sendActions(for: .touchUpInside)
        
    }
    
    
    
    @objc func complete(_ sender: Any) {

        
        
        let indexPath = IndexPath(row: (sender as AnyObject).tag, section: 0)
        let celltable = tableView.cellForRow(at: indexPath) as! VaccineTableViewCell
        
        let alert = UIAlertController(title: ("enter_hospilal_name").localiz(), message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ("cancel").localiz(), style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = ("hospital_name").localiz()
        })
        
        alert.addAction(UIAlertAction(title: ("ok").localiz(), style: .default, handler: { action in
            
            if let name = alert.textFields?.first?.text {
               
                let act = JGProgressHUD(style: .light)
                
                act.textLabel.text = ("loading").localiz()
                
                act.show(in: self.view)
//                print("vac")
//                print(self.vaccine[indexPath.row].vaccine_id!)
//                print("name")
//                print(name)
//                print("child")
//                print(self.child_id)
//                print("momId")
//                print(self.momId)
                Alamofire.request(self.functions.apiLink()+"apis/kid_vaccination.php",method: .post, parameters: [
                    "vaccine_id": self.vaccine[indexPath.row].vaccine_id!, "hospital": name, "kid_id": self.child_id, "mother_id":self.momId])
                    .validate(statusCode: 200..<300)
                    
                    .response { response in
                    
                       
                        celltable.completeText.text = ("complete").localiz()
                        celltable.completeText.textColor = self.functions.hexStringToUIColor(hex: "64d98d")
                        (sender as AnyObject).setImage(UIImage(named:"syringe_on.png"), for: .normal)
                        self.vaccine[indexPath.row].hospital = name
                        self.vaccine[indexPath.row].completed = "true"
                        celltable.hospital.text = name
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                            UIView.animate(withDuration: 0.3) {
                                act.indicatorView = nil
                                act.textLabel.font = UIFont.systemFont(ofSize: 18.0)
                                act.textLabel.text = ("Done").localiz()
                                act.position = .bottomCenter
                            }
                        }
                        
                        act.dismiss(afterDelay: 2.0)
                }
 
            }
        }))
        
        self.present(alert, animated: true)


        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let dat : Vaccine = usedData[indexPath.row]
        
        if dat.type == "month"{

            return 60.0
           }else{
            
            return 150.0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dat : Vaccine = usedData[indexPath.row]
        
        if dat.type == "month"{
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! VaccineTableViewCell
            cell.monthLabel.text = ("month").localiz()+" \(dat.month_nb!)"
      
             return cell
            
            
            
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VaccineTableViewCell
        
   
            
         
            let strDOB = self.child_age
            
            
            if accounttype == "4"{
                cell.titleVaccine.frame = CGRect(x: 20,y: 20, width: 280, height: 23)
                cell.currentImage.isHidden = true
                cell.completeText.isHidden = true
                
            }
            
            
            
            let ageComponents = strDOB.components(separatedBy: "-")
            
            
            let dateDOB = Calendar.current.date(from: DateComponents(year:
                Int(ageComponents[0]), month: Int(ageComponents[1]), day:
                Int(ageComponents[2])))!
            
            
            let myAge =  dateDOB.age
            

            
            
            if myAge <= dat.age!{
                cell.lockView.isHidden = false
            }else{
                cell.lockView.isHidden = true
            }
            
            

            let tapGesture = MyTapGesture(target: self, action: #selector(self.tapLock(_ :)))
            
            cell.lockView.addGestureRecognizer(tapGesture)
            tapGesture.cell = cell
            cell.lockView.isUserInteractionEnabled = true
            
   
        if functions.lang() == "ar"{
        cell.titleVaccine.text = dat.arabic_name
        }else{
        cell.titleVaccine.text = dat.title
        }
        cell.hospital.text = dat.hospital
        cell.roundView.layer.shadowRadius = 5
        cell.roundView.layer.shadowOpacity = 0.2
        cell.layer.masksToBounds = false
        cell.clipsToBounds = false
        cell.roundView.layer.masksToBounds = false
        cell.roundView.clipsToBounds = false
        cell.roundView.layer.shadowOffset = CGSize(width: 0, height:1.0)
        cell.roundView.layer.shadowColor = UIColor.black.cgColor
        
        if dat.completed == "false"{
        cell.completeText.text = ("incomplete").localiz()
        cell.completeText.textColor = functions.hexStringToUIColor(hex: "d6d6d6")
        cell.currentImage.tag = indexPath.row
        cell.currentImage.addTarget(self, action: #selector(complete), for: UIControlEvents.touchUpInside)
        cell.currentImage.setImage(UIImage(named:"syringe_off.png"), for: .normal)
      
        }else{

         cell.currentImage.setImage(UIImage(named:"syringe_on.png"), for: .normal)
         cell.completeText.text = ("complete").localiz()
         cell.completeText.textColor = functions.hexStringToUIColor(hex: "64d98d")
        }
            

            
            
        cell.tapText.tag = indexPath.row
        cell.tapText.addTarget(self, action: #selector(tapInfo), for: UIControlEvents.touchUpInside)
        cell.tapText.setTitle(("tapForInfo").localiz(), for: .normal)

        return cell
        }
 
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.filterYears.layer.cornerRadius = filterYears.bounds.height/2
        self.filterYears.layer.masksToBounds = true
        self.filterYears.layer.borderWidth = 1.0
        self.filterYears.layer.borderColor = #colorLiteral(red: 0.7975881696, green: 0.6346347332, blue: 0.233198911, alpha: 1)
        if accounttype == "4"{
            designFooter()
        }
        filterYears.setTitle(("year1").localiz(), forSegmentAt: 0)
        
        filterYears.setTitle(("year2").localiz(), forSegmentAt: 1)
        
        filterYears.setTitle(("year3").localiz(), forSegmentAt: 2)
        
        
        
        
        
        
        //yellowLine.alpha = 0.0
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = ("loading").localiz()
        hud.show(in:self.view)
        
        self.yellowLine.isHidden = true
        if accounttype == "4"{
        self.title = ("vaccination").localiz()
        }else{
        self.title = ("vaccination").localiz()+" - "+self.child_name.uppercased()

            
        }
        
            
            //  functions.menuRight(controller: self)

        momId = KeychainWrapper.standard.string(forKey: "uid")!
        countryId = KeychainWrapper.standard.string(forKey: "country_id")!
        
      //  print(countryId)
        
        let URL_GET_DATA = functions.apiLink()+"vaccination.json/"+countryId+"?child_id="+child_id
      //  print(URL_GET_DATA)
        var age : Int = 0
      
        Alamofire.request(URL_GET_DATA).responseJSON { response in
            
            //getting json
            if let json = response.result.value {
                let js = JSON(json)

  
                for i in 0..<js.count{
                    
                  
                    if i == 0{
                        
                        self.vaccine.append(Vaccine(
                            
                            title:  "",
                            arabic_name:  "",
                            thumb_image:  "",
                            body:  "",
                            arabic_body:  "",
                            country:  "",
                            nid:  "",
                            age:  "",
                            vaccine_id:  "",
                            kid_id:  "",
                            vaccine_kid:  "",
                            hospital:  "",
                            completed:  "",
                            planned:  "",
                            completed_date: "",
                            type: "month",
                            month_nb: Int(js[i]["age"].string!)!
                            
                        ))
                        
                        age = Int(js[i]["age"].string!)!
                        
                        self.vaccine.append(Vaccine(
                            
                            title: js[i]["title"].string,
                            arabic_name: js[i]["arabic_name"].string,
                            thumb_image: js[i]["thumb_image"].string,
                            body: js[i]["body"].string,
                            arabic_body: js[i]["arabic_body"].string,
                            country: js[i]["country"].string,
                            nid: js[i]["nid"].string,
                            age: js[i]["age"].string,
                            vaccine_id: js[i]["kid_vaccination"]["vaccine_id"].string,
                            kid_id: js[i]["kid_vaccination"]["kid_id"].string,
                            vaccine_kid: js[i]["kid_vaccination"]["vaccine_kid"].string,
                            hospital: js[i]["kid_vaccination"]["hospital"].string,
                            completed: js[i]["kid_vaccination"]["completed"].string,
                            planned: js[i]["kid_vaccination"]["planned"].string,
                            completed_date: js[i]["kid_vaccination"]["completed_date"].string,
                            type: "normal",
                            month_nb: Int(js[i]["age"].string!)!
                            
                        ))
                        
                        
                    }else{
                    
                        
                        if Int(js[i]["age"].string!)! > age {
                            
                            self.vaccine.append(Vaccine(
                                
                                
                                title:  "",
                                arabic_name:  "",
                                thumb_image:  "",
                                body:  "",
                                arabic_body:  "",
                                country:  "",
                                nid:  "",
                                age:  "",
                                vaccine_id:  "",
                                kid_id:  "",
                                vaccine_kid:  "",
                                hospital:  "",
                                completed:  "",
                                planned:  "",
                                completed_date: "",
                                type: "month",
                                month_nb: Int(js[i]["age"].string!)!
                                
                            ))
                               age = Int(js[i]["age"].string!)!
                            
                        }

                    self.vaccine.append(Vaccine(
                        
                        title: js[i]["title"].string,
                        arabic_name: js[i]["arabic_name"].string,
                        thumb_image: js[i]["thumb_image"].string,
                        body: js[i]["body"].string,
                        arabic_body: js[i]["arabic_body"].string,
                        country: js[i]["country"].string,
                        nid: js[i]["nid"].string,
                        age: js[i]["age"].string,
                        vaccine_id: js[i]["kid_vaccination"]["vaccine_id"].string,
                        kid_id: js[i]["kid_vaccination"]["kid_id"].string,
                        vaccine_kid: js[i]["kid_vaccination"]["vaccine_kid"].string,
                        hospital: js[i]["kid_vaccination"]["hospital"].string,
                        completed: js[i]["kid_vaccination"]["completed"].string,
                        planned: js[i]["kid_vaccination"]["planned"].string,
                        completed_date: js[i]["kid_vaccination"]["completed_date"].string,
                        type: "normal",
                        month_nb: Int(js[i]["age"].string!)!
                        
                      )  )}
                }
            }
            self.yellowLine.isHidden = false
            self.usedData = self.vaccine
            self.filterCollectionView(age:12)
            hud.dismiss(afterDelay:0.5)
            self.tableView.reloadData()
        }

     
       self.tableView.reloadData()
        
    }

    
    func filterCollectionView(age:Int){
        usedData = vaccine
        
        switch age{
            
        case 12:
     
            dataAry = usedData.filter({(mod) -> Bool in

                return  mod.month_nb!  <= 12 &&  mod.month_nb!  >= 0
 
            })
            
            usedData = dataAry
            
            if usedData.count > 0{
                self.yellowLine.isHidden = false
            }else{
                self.yellowLine.isHidden = true
            }
            self.tableView.reloadData()
         self.functions.numberOfSections(in: tableView, data: usedData.count)
            
            
        case 24:
            //   print("w2")
            dataAry = usedData.filter({(mod) -> Bool in
 
                return  mod.month_nb!  <= 24 &&  mod.month_nb!  > 12
 
            })
            usedData = dataAry
      
            if usedData.count > 0{
                self.yellowLine.isHidden = false
            }else{
                self.yellowLine.isHidden = true
            }
       
            
             self.tableView.reloadData()
            
            self.functions.numberOfSections(in: tableView, data: usedData.count)
            
        case 36:
            //     print("w3")
            dataAry = usedData.filter({(mod) -> Bool in
                
                
                return  mod.month_nb!  <= 36 &&  mod.month_nb!  > 24
                
                
            })
            usedData = dataAry
            
            if usedData.count > 0{
                self.yellowLine.isHidden = false
            }else{
                self.yellowLine.isHidden = true
            }
             self.tableView.reloadData()
            
              self.functions.numberOfSections(in: tableView, data: usedData.count)
            
            
        default:
            dataAry = usedData.filter({(mod) -> Bool in return Int(mod.month_nb!) == age})
            usedData = dataAry
           self.tableView.reloadData()
        }
        
    }
    
    
    
    @IBAction func segmentedChanged(_ sender: Any) {
        
        switch filterYears.selectedSegmentIndex
        {
        case 0:
            filterCollectionView(age:12)
        case 1:
            filterCollectionView(age:24)
        case 2:
            filterCollectionView(age:36)
        default:
            break
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openRightMenu(_ sender: UIBarButtonItem) {
        
        if functions.lang() == "ar"{
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        }else{
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        }
        
    }
    
    func designFooter() {
        
        let viewFooter: UIView! = UIView(frame: CGRect(x:0, y: self.view.bounds.size.height - 33, width: self.view.bounds.size.width, height: 33))
        
        viewFooter.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.8862745098, blue: 0.6235294118, alpha: 1)
        self.view!.addSubview(viewFooter)
        
        let noDataLabel : UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: viewFooter.bounds.size.width, height: 33))
       noDataLabel.text = ("prof_use").localiz()
 
        noDataLabel.textAlignment = .center
        noDataLabel.font = UIFont(name: "Gotham-Book", size: 14)
     
        viewFooter.addSubview(noDataLabel)
    }

}

class MyTapGesture: UITapGestureRecognizer {
    var cell : VaccineTableViewCell!
}
