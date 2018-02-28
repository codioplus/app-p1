//
//  LoginViewController.swift
//  Nestle
//
//  Created by User on 2/27/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: TextfieldBorderBottom!
    @IBOutlet weak var passwordField: TextfieldBorderBottom!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      usernameField.placeholder = NSLocalizedString("placeholderUsernameField", comment: "username field")
        
    passwordField.placeholder = NSLocalizedString("placeholderPasswordField", comment: "password field")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
