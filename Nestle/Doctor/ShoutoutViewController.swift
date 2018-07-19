//
//  ShoutoutViewController.swift
//  Nestle
//
//  Created by User on 6/4/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import Kingfisher
import JGProgressHUD

class ShoutoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let functions = Functions()
    var model = [Shoutout]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addShout: UIButton!
    var timer : Timer!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addShout.setTitle(("addshout").localiz(), for: .normal)
        let hud = JGProgressHUD(style: .light)
        self.title = ("doc_notifications").localiz()
        hud.textLabel.text = ("loading").localiz()
        hud.show(in:self.view)
        designFooter()
        
        let  _ = APIManager.shared.fetchShoutApi()
            .done{
                shoutout  in
                
                self.model = shoutout
                
                self.tableView.reloadData()
              
                hud.dismiss(afterDelay: 0.5)
            }.catch{ error
                -> Void in
                hud.dismiss(afterDelay: 0.5)
                
        }
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
           self.timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(reloadTableData), userInfo: nil, repeats: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        self.timer.invalidate()
    }
    
    
    
    
    @objc func reloadTableData(){
        
        
        let  _ = APIManager.shared.fetchShoutApi()
            .done{
                shoutout  in
                
                self.model = shoutout
                
                self.tableView.reloadData()
          
            }.catch{ error
                -> Void in
       
        }
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "ShoutViewController") as! ShoutViewController
        Dvc.shoutTle = model[indexPath.row].title!
        Dvc.image = model[indexPath.row].image!
        Dvc.body = model[indexPath.row].body!
        self.navigationController?.pushViewController(Dvc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ShoutoutTableViewCell
        let dat : Shoutout = model[indexPath.row]
        


        if let imageUrlString = dat.image{
            if let imageUrl = URL(string: imageUrlString){
                do{

                    cell.imageDoc.kf.setImage(with: imageUrl)

                }
            }else{

                cell.imageDoc.image = UIImage(named : "no_profile")
            }
        }else{

            cell.imageDoc.image = UIImage(named : "no_profile")
        }

        cell.title.text = dat.title
        
        cell.Desc.text = dat.body
        
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
