//
//  SignupViewController.swift
//  Nestle
//
//  Created by User on 2/28/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var joinNowTextBtn: RoundBtn!

    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        
        
        self.title = NSLocalizedString("signupViewTitle", comment: "sign up")
        joinNowTextBtn.setTitle(NSLocalizedString("joinNow", comment: "Join now"), for: .normal)
     
        

        
//
//        let currentUser = backendless.userService.currentUser
//        let pictureURL = currentUser.getProperty("picture")
//        let url = NSURL(string: pictureURL as! String)
//        data = NSData(contentsOfURL:url!)
//        if data != nil {
//            profileImage?.image = UIImage(data:data! as Data)
//        }
        
        
        
        
    }


    



}
