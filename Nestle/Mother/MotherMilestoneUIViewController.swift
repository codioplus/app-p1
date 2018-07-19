//
//  MotherMilestoneUIViewController.swift
//  Nestle
//
//  Created by User on 4/10/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import JGProgressHUD
import SideMenu
class MotherMilestoneUIViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet weak var collectionView: UICollectionView!
    

    @IBOutlet weak var filterYears: UISegmentedControl!
    
    let array:[String] = ["profile_image","2","3"]
    var type = String()
    var type_id = Int()
    var child_id = String()
    var child_age = String()
    var child_name = String()
    let functions = Functions()
    var data = [Dataserver]()
    var dataAry = [Dataserver]()
    var usedData = [Dataserver]()
    var URL_GET_DATA : String = ""
     var momId = String()
     var titleJson:String = "title"

     let accounttype = KeychainWrapper.standard.string(forKey: "accounttype")!

       let hd = JGProgressHUD(style: .light)
    override func viewDidLoad() {
      super.viewDidLoad()
      
        self.filterYears.layer.cornerRadius = filterYears.bounds.height/2
        self.filterYears.layer.masksToBounds = true
        self.filterYears.layer.borderWidth = 1.0
        self.filterYears.layer.borderColor = #colorLiteral(red: 0.7975881696, green: 0.6346347332, blue: 0.233198911, alpha: 1)
        if accounttype == "4"{
            designFooter()
        }
        
        
        

        momId = KeychainWrapper.standard.string(forKey: "uid")!
        if type == "favourite"{

            self.title = ("favourite").localiz()
        }
        else if type == "milestone"{
            if accounttype == "4"{
            self.title = ("milestone").localiz()
            }else{
          self.title = ("milestone").localiz()+" - "+child_name.uppercased()
                
            }

            
            
        }else if type == "video"{
            if accounttype == "4"{
                self.title = ("videos").localiz()
            }else{
               self.title = ("videos").localiz()+" - "+child_name.uppercased()
                
            }
            
         
            
            
        }
        else if type == "feeding"{
            if accounttype == "4"{
             self.title = ("feeding_tips").localiz()
            }else{
              self.title = ("feeding_tips").localiz()+" - "+child_name.uppercased()
                
            }
        
            
        }
        else if type == "parent"{
            
            if accounttype == "4"{
            self.title = ("parent_tips").localiz()
            }else{
                
           self.title = ("parent_tips").localiz()+" - "+child_name.uppercased()
            }
            

        }
        else if type == "brain"{
            
            if accounttype == "4"{
             self.title = ("brain_activities").localiz()
            }else{
                
            self.title = ("brain_activities").localiz()+" - "+child_name.uppercased()
            }
            
            
            
        
        }
 
        filterYears.setTitle(("year1").localiz(), forSegmentAt: 0)
        
        filterYears.setTitle(("year2").localiz(), forSegmentAt: 1)
        
        filterYears.setTitle(("year3").localiz(), forSegmentAt: 2)
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
        layout.minimumInteritemSpacing = 20
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 50)/2, height: 230)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
      
        super.viewWillAppear(false)
        
        
        self.data = [Dataserver]()
        
        self.dataAry = [Dataserver]()
        
        self.usedData = [Dataserver]()
        
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = ("loading").localiz()
        hud.show(in:self.view)
        


        if type == "favourite"{
            URL_GET_DATA = functions.apiLink()+"apis/favourite.php?uid="+momId
        }
            
        else if type == "milestone"{
            URL_GET_DATA = functions.apiLink()+functions.lang()+"/milestone.json?uid="+momId
        }
        else if type == "feeding"  || type == "parent" || type == "brain"{
            URL_GET_DATA = functions.apiLink()+functions.lang()+"/tips.json/\(type_id)?uid="+momId
        }
            
        else if type == "video" {
            URL_GET_DATA = functions.apiLink()+"videos.json/?uid="+momId
        }
        else{
            URL_GET_DATA = functions.apiLink()+functions.lang()+"/milestone.json"
        }
        
        //   print(URL_GET_DATA)
        
        Alamofire.request(URL_GET_DATA).responseJSON { response in
            
            //getting json
            if let val = response.result.value {
                let json = JSON(val)
                //converting json to NSArray
                //  let dataArray : NSArray  = json as! NSArray
                
                
                //traversing through all elements of the array
                
                if self.type == "video" &&  self.functions.lang() == "ar"{
                    self.titleJson = "title_ar"
                }
                
                for i in 0..<json.count{
                    
                    self.data.append(Dataserver(
                        
                        
                        title: json[i][self.titleJson].string,
                        nid: json[i]["nid"].string,
                        thumb_image: json[i]["thumb_image"].string,
                        age: json[i]["age"].string,
                        image: json[i]["image"].string,
                        current_uid: json[i]["current_uid"].string,
                        isFlagged: json[i]["isFlagged"].string,
                        rate_average: json[i]["rate_average"].string,
                        youtube_id: json[i]["youtube_id"].string,
                        
                        p1: json[i]["grouping_votes"]["p1"].int!,
                        p2: json[i]["grouping_votes"]["p2"].int!,
                        p3: json[i]["grouping_votes"]["p3"].int!,
                        p4: json[i]["grouping_votes"]["p4"].int!,
                        p5: json[i]["grouping_votes"]["p5"].int!,
                        count_user_rate: json[i]["count_user_rate"].string!,
                        
                        is_rate: json[i]["is_rate"].string,
                        rate_value: json[i]["rate_value"].string
                    ))
                    
                }
            }
            // print(self.data[0].rate_value)
            
             self.usedData = self.data
            if self.filterYears.selectedSegmentIndex == 0{
                self.filterCollectionView(age:12)
            }else if self.filterYears.selectedSegmentIndex == 1{
                self.filterCollectionView(age:24)
                
            }else if self.filterYears.selectedSegmentIndex == 2{
                self.filterCollectionView(age:36)
                
            }else{
               self.filterCollectionView(age:12)
                
            }
            
            
            
           
            
            
            
            self.collectionView.reloadData()
            hud.dismiss(afterDelay:0.5)
        
   
        
        }
        
        self.collectionView.reloadData()
        
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
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
        hd.dismiss(afterDelay:0.5)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if usedData.count > 0{
        return usedData.count
        }else{
            return 0
        }
    }
    
    func filterCollectionView(age:Int){
      usedData = data
        switch age{
            
        case 12:
       //   print("w1")
        dataAry = usedData.filter({(mod) -> Bool in
            

                
    return  mod.age!  <= 12 &&  mod.age!  >= 0
                
      
            
        })
         usedData = dataAry
        
            self.functions.numberOfSectionsCollection(in: collectionView, data: usedData.count)
        
        
            self.collectionView.reloadData()
            
        
            
        case 24:
       //   print("w2")
       dataAry = usedData.filter({(mod) -> Bool in
 

            
         return  mod.age!  <= 24 &&  mod.age!  > 12
          
            

 
       })
           usedData = dataAry
           self.functions.numberOfSectionsCollection(in: collectionView, data: usedData.count)
       
     //  print("ok2")
     //  print(usedData.count)
     //  print("ok3")
   
        self.collectionView.reloadData()
            
          
            
        case 36:
       //     print("w3")
        dataAry = usedData.filter({(mod) -> Bool in
          
                
              return  mod.age!  <= 36 &&  mod.age!  > 24
      
            
        })
         usedData = dataAry
           self.functions.numberOfSectionsCollection(in: collectionView, data: usedData.count)
    self.collectionView.reloadData()
            
            

    
        default:
            dataAry = usedData.filter({(mod) -> Bool in return Int(mod.age!) == age})
            usedData = dataAry
           collectionView.reloadData()
    }
    
    }
    
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DataCollectionViewCell
        

        if usedData.count == 0{
            return cell
        }
        
        
        let dat : Dataserver = usedData[indexPath.row]
        
        if let rate = dat.rate_average{
            
            cell.rateView.rating = rate
        }
        
        if let imageUrlString = dat.thumb_image{
            
            if let imageUrl = URL(string: imageUrlString){
                do{
                    
                    cell.myImage.kf.setImage(with: imageUrl)
             
                }
            }
        }

//        print(self.child_age)
//        print("yyyyyyy ")
//        print(dat.age)
        


        


            let strDOB = self.child_age
            
            let ageComponents = strDOB.components(separatedBy: "-")
      
    
            let dateDOB = Calendar.current.date(from: DateComponents(year:
                Int(ageComponents[0]), month: Int(ageComponents[1]), day:
                Int(ageComponents[2])))!
        
            
        let myAge =  dateDOB.age //functions.accurateRound(value: Double(dateDOB.ageDay/30))
            
            
            
           print("\(myAge) | \(dat.age!)")
            
    
                if myAge <= dat.age!{
                 cell.lockView.isHidden = false
                }else{
                 cell.lockView.isHidden = true
                }
            
        
         cell.title.text  = dat.title!
        
        if let isFlagged = dat.isFlagged{
        
        do {
            
            if isFlagged ==  "true"{
        cell.favourite.image = UIImage(named: "ic_heart_on.png")
            }else{
          cell.favourite.image = UIImage(named: "ic_heart_off.png")
            }
        }
        }
        

      
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        
        
       let dat : Dataserver = usedData[indexPath.row]
        let strDOB = self.child_age
        
        let ageComponents = strDOB.components(separatedBy: "-")
      //  print(ageComponents)
        let dateDOB = Calendar.current.date(from: DateComponents(year:
            Int(ageComponents[0]), month: Int(ageComponents[1]), day:
            Int(ageComponents[2])))!
        
        
        let myAge =  dateDOB.age
        
        
        
       print("\(myAge) | \(dat.age!)")
        
      
        if myAge <= dat.age!{
            
            return
            
        }else{
            
         
            hd.textLabel.text = ("loading").localiz()
            hd.show(in:self.view)
DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    
            self.performSegue(withIdentifier: "showDetails", sender: self)
    
            }
        }
        
  
    }



    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        

        
        if let indexPath = self.collectionView.indexPathsForSelectedItems?.first {
        self.collectionView.deselectItem(at: indexPath, animated: true)
            let detail = usedData[indexPath.row]
        if let destination = segue.destination as? DetailViewController {
            
            
      
            
            
            destination.detail = detail
            destination.nid = detail.nid!
            destination.type = self.type
            destination.type_id = self.type_id
            destination.child_id = self.child_id
            destination.child_age = self.child_age
            destination.child_name = self.child_name
            
        }
        }
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


extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.month], from: self, to: Date()).month!
    }
    var ageDay: Int {
        return Calendar.current.dateComponents([.day], from: self, to: Date()).day!
    }
}




