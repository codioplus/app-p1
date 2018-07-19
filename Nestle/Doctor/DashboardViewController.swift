//
//  DashboardViewController.swift
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
class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    let functions = Functions()
    var dashboardData = [Dashboard]()
//{"average_ages":"9", "kids_registered":"4", "family_registed":"25", "nb_shoutouts":"0", "freq_visits":"0"}
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {

        super.viewDidLoad()
        
      //  self.navigationItem.setHidesBackButton(true, animated: false)
   
        // functions.menuRight(controller: self)
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = ("loading").localiz()
        hud.show(in:self.view)
        designFooter()
        self.title = ("dashboard").localiz()
       // functions.menuRight(controller: self)
        let momId : String? = KeychainWrapper.standard.string(forKey: "uid")
        let URL_GET_DATA = functions.apiLink()+"apis/dashboard.php?doctor_id="+momId!
        Alamofire.request(URL_GET_DATA).responseJSON { response in
            
            //getting json
            if let json = response.result.value {
                
             let val = JSON(json)

                self.dashboardData.append(Dashboard(
                    title: ("family_registed").localiz() ,
                    nb: val["family_registed"].string!,
                    image:"families-registered.pdf"
                ))
                
                
       
                    
           
               self.dashboardData.append(Dashboard(
                        title: ("kids_registered").localiz() ,
                        nb: val["kids_registered"].string!,
                        image:"child-registed.pdf"
                    ))
                    

                    
                self.dashboardData.append(Dashboard(
                    title: ("average_ages").localiz() ,
                    nb: val["average_ages"].string!,
                    image:"averages-ages.pdf"
                ))
                
                self.dashboardData.append(Dashboard(
                    title: ("nb_shoutouts").localiz() ,
                    nb: val["nb_shoutouts"].string!,
                    image:"nb-shoutout.pdf"
                ))
                
                self.dashboardData.append(Dashboard(
                    title: ("freq_visits").localiz() ,
                    nb: val["freq_visits"].string!,
                    image:"frequency-of-app-visits.pdf"
                ))
                    
                hud.dismiss(afterDelay:0.5)
                self.tableView.reloadData()
            }
            
        }
        
        
       self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashboardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DashboardTableViewCell
        
        let dashboard : Dashboard = dashboardData[indexPath.row]
       
        cell.nb.text = dashboard.nb
        cell.title.text = dashboard.title
        cell.imageDashboard.image = UIImage(named: dashboard.image)
        
        
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.cornerRadius = 15
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.masksToBounds = false
        
        
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
