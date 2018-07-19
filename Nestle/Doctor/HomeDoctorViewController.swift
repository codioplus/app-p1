//
//  HomeDoctorViewController.swift
//  Nestle
//
//  Created by User on 5/28/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import SideMenu

class HomeDoctorViewController: UIViewController {
        let functions = Functions()
    @IBOutlet weak var footerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       self.navigationItem.setHidesBackButton(true, animated: false)
        
    functions.menuRight(controller: self)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.title = ("home").localiz()
        
        self.footerLabel.text = ("prof_use").localiz()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    @IBAction func openRightMenu(_ sender: UIBarButtonItem) {
        if functions.lang() == "ar"{
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        }else{
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        }
    }
    
    
}
