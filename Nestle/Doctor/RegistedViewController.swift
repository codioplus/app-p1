//
//  RegistedViewController.swift
//  Nestle
//
//  Created by User on 5/30/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import Kingfisher
import JGProgressHUD

class RegistedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource {
  let functions = Functions()
    var model = [Families]()
   // var kidArray = [Kid]()
    
    
    var storedOffsets = [Int : CGFloat]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300
        
        
        
        let hud = JGProgressHUD(style: .light)
        self.title = ("registered_families").localiz()
        hud.textLabel.text = ("loading").localiz()
        hud.show(in:self.view)
        designFooter()
        
      let  _ = APIManager.shared.fetchFamiliesApi()
        .done{
            kid  in
            self.model = kid
            self.tableView.reloadData()
          //dump(self.model)
                   hud.dismiss(afterDelay: 0.5)
            }.catch{ error
                -> Void in
                    hud.dismiss(afterDelay: 0.5)
                
        }
      //  self.tableView.reloadData()
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let kidCount = model[indexPath.row].kid?.count
        if let kidd = kidCount{
        if kidd > 0{
            if kidCount!%2 == 0{
            return CGFloat(((kidCount!/2)*70)+165)
            }else{
             return CGFloat(((kidCount!/2)*70)+165+70)
            }
        }else{
            
                return 165
            
            }
  
            
        }
        return 165
    }
    

 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return model.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "RegistedTableViewCell") as! RegistedTableViewCell
    let dat : Families = model[indexPath.row]
    
    
    cell.layoutIfNeeded()
    cell.clCollectionView.reloadData()
   

    cell.name.text = dat.mom_name
    if functions.lang() == "ar"{
        cell.country.text = dat.country_name_ar
    }else{
    cell.country.text = dat.country_name
    }
    if let imageUrlString = dat.profile_image{
        if let imageUrl = URL(string: imageUrlString){
            do{
             // cell.motherImage.image = UIImage(named : "no_profile.png")
                cell.motherImage.kf.setImage(with: imageUrl)
                
            }
        }else{
            
            cell.motherImage.image = UIImage(named : "no_profile.png")
        }
    }else{
        
        cell.motherImage.image = UIImage(named : "no_profile.png")
    }
    
  return cell
 }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         guard  let tableViewCell = cell as? RegistedTableViewCell else {return}
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      guard  let tableViewCell = cell as? RegistedTableViewCell else {return}
     storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model[collectionView.tag].kid!.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView,  cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegistedCollectionViewCell", for: indexPath) as! RegistedCollectionViewCell
        
        let dat : Kid = model[collectionView.tag].kid![indexPath.row]
        //print("ah"+"\(indexPath.row)")
       // print(dat)
         //  print("ah"+"\(indexPath.row)")
        cell.childName.text = dat.title
        
        
        
        if let strDOB = dat.dob{
        
        let ageComponents = strDOB.components(separatedBy: "-")
        
        let dateDOB = Calendar.current.date(from: DateComponents(year:
            Int(ageComponents[0]), month: Int(ageComponents[1]), day:
            Int(ageComponents[2])))!
        
        
        let myAge = dateDOB.age
        
        if myAge == 1{
            cell.childage.text = "\(myAge) \(("month").localiz())"
        }else{
            cell.childage.text = "\(myAge) \(("months").localiz())"
        }
        
        }
        if functions.lang() == "ar"{
        cell.childage.textAlignment = LanguageManger.shared.isRightToLeft ? .right : .left
        }

        

        
        
        if let imageUrlString = dat.profile_image{
            if let imageUrl = URL(string: imageUrlString){
                do{
                    
                    cell.childImage.kf.setImage(with: imageUrl)
                //  cell.childImage.image = UIImage(named : "no_profile.png")
                }
            }
        else{
            
            cell.childImage.image = UIImage(named : "no_profile.png")
        }
    }else{
    
       cell.childImage.image = UIImage(named : "no_profile.png")
    }
        
        if dat.gender == "female"{
            
            cell.childImage.layer.borderColor =  #colorLiteral(red: 0.9607843137, green: 0.4784313725, blue: 0.5098039216, alpha: 1)
        }else{
            cell.childImage.layer.borderColor = #colorLiteral(red: 0.3647058824, green: 0.7098039216, blue: 0.6431372549, alpha: 1)
        }
        return cell
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
