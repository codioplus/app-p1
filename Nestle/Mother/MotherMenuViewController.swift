//
//  MotherMenuViewController.swift
//  Nestle
//
//  Created by User on 4/25/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class MotherMenuViewController: UIViewController {

let functions = Functions()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signoutBtn(_ sender: Any) {
        

        if  let token: String = KeychainWrapper.standard.string(forKey: "token"){

        print(token)
            
            
            
            
                let headers: HTTPHeaders = [
                    "Content-Type": "application/json",
                    "Accept": "application/json",
                    "X-CSRF-Token": token
                ]
        
                let parameters: Parameters = [:]
        
                let url = functions.apiLink()+"app-api/user/logout"
        
                Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON { response in
                    switch response.result {
                    case .success:
                      print(response.result)
                      
                      KeychainWrapper.standard.removeObject(forKey: "token")
                        
                        
                      DispatchQueue.main.async
                        {
                            
                            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let Dvc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                            
                            self.navigationController?.pushViewController(Dvc, animated: true)
                            
                        }
                        
                        
                        
        
                    case .failure(let error):
                        print(error)
                    }
        
                }
    
    }
    }
}

