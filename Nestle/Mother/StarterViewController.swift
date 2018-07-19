//
//  StarterViewController.swift
//  Nestle
//
//  Created by User on 5/23/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper


class StarterViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        if let saved_token : String = UserDefaults.standard.string(forKey: "token"){
            
            let accounttype = KeychainWrapper.standard.string(forKey: "accounttype")!
    
                if accounttype == "4"{
             
                
                    let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let Dvc = Storyboard.instantiateViewController(withIdentifier: "HomeDoctorViewController") as! HomeDoctorViewController
                    
                    self.navigationController?.pushViewController(Dvc, animated: false)
                    
                }else{
            
           
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "HomeTableViewController")
                as! HomeTableViewController


            self.navigationController?.pushViewController(Dvc, animated: false)
                
                
                
                
                
            
            }
            
            

        }else{

            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

            self.navigationController?.pushViewController(Dvc, animated: false)



        }
    }


}

/*
class StarterViewController : UINavigationController{

        override func viewDidLoad() {
            super.viewDidLoad()
    print("ghfhghfh")
        if let saved_token : String = UserDefaults.standard.string(forKey: "token"){
            print(saved_token)


//                        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
//                        let Dvc = Storyboard.instantiateViewController(withIdentifier: "HomeTableViewController")
//                            as! HomeTableViewController
//
//
//                        self.navigationController?.pushViewController(Dvc, animated: false)

            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
   self.present(HomeTableViewController(), animated: false, completion: nil)
            }
 
//viewControllers = [HomeTableViewController()]

            }else{

//                        print("eeee")
//                        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
//                        let Dvc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//
//                        self.navigationController?.pushViewController(Dvc, animated: false)

            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {

    self.present(LoginViewController(), animated: false, completion: nil)
            }
      //      viewControllers = [LoginViewController()]

            }
        }

}
*/
