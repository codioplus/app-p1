//
//  ShoutViewController.swift
//  Nestle
//
//  Created by User on 6/4/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import SideMenu

class ShoutViewController: UIViewController {

    @IBOutlet weak var shoutImage: UIImageView!
    @IBOutlet weak var shoutDesc: UITextView!
    @IBOutlet weak var shoutTitle: UILabel!
    
    var shoutTle : String?
    var image : String?
    var body : String?
    let functions = Functions()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designFooter()
        self.title = ("doc_notifications").localiz()
        self.shoutTitle.text = self.shoutTle
     
        
        if let imageUrlString = image{
            if let imageUrl = URL(string: imageUrlString){
                do{
                    
                   self.shoutImage.kf.setImage(with: imageUrl)
                    
                }
            }
        }
        self.shoutDesc.text = self.body
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    @IBAction func openRightMenu(_ sender: UIBarButtonItem) {
        
        if functions.lang() == "ar"{
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        }else{
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        }
    }
}
