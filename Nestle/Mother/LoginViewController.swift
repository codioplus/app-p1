//
//  LoginViewController.swift
//  Nestle
//
//  Created by User on 2/27/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class LoginViewController: UIViewController, UITextFieldDelegate {

    let functions = Functions()
    
    
    @IBOutlet weak var usernameField: TextfieldBorderBottom!
    @IBOutlet weak var passwordField: TextfieldBorderBottom!
    @IBOutlet weak var notUserText: UILabel!
    @IBOutlet weak var signUpBtnText: UIButton!
    @IBOutlet weak var loginBtnText: RoundBtn!
    
    var tok:String = ""
    let signUpBtnTextAttributes : [NSAttributedStringKey: Any] = [
        NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
    
    override func viewDidLoad() {
        
        
        if let saved_token : String = KeychainWrapper.standard.string(forKey: "token"){
            print(saved_token)
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "KidsTableViewController") as! KidsTableViewController
            
            self.navigationController?.pushViewController(Dvc, animated: true)
            
        }
        
        
        
        
        super.viewDidLoad()
     usernameField.delegate = self;
     passwordField.delegate = self;
    usernameField.placeholder = NSLocalizedString("placeholderUsernameField", comment: "Username Field")
        
    passwordField.placeholder = NSLocalizedString("placeholderPasswordField", comment: "Password Field")
  
    notUserText.text = NSLocalizedString("notUserLabelText", comment: "Not a User")
   
    loginBtnText.setTitle(NSLocalizedString("loginBtn", comment: "Login"), for: .normal)
        
        
    let attributeString = NSMutableAttributedString(string: NSLocalizedString("signUpBtnText", comment: "Sign up"),attributes: signUpBtnTextAttributes)
        signUpBtnText.setAttributedTitle(attributeString, for: .normal)
    
        
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
    
    @IBAction func registerNewAccountButtonTapped(_ sender: Any) {
//       
//        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
//        
//        self.present(registerViewController, animated:true)
//    
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        
        self.navigationController?.pushViewController(Dvc, animated: true)
        
        
    }
    
    @IBAction func signInTappedBtn(_ sender: Any) {
       
        
        print("Sign in button tapped")
        
        // Read values from text fields
        let userName = usernameField.text
        let userPassword = passwordField.text
        
        // Check if required fields are not empty
        if (userName?.isEmpty)! || (userPassword?.isEmpty)!
        {
            // Display alert message here
            print("User name \(String(describing: userName)) or password \(String(describing: userPassword)) is empty")
            displayMessage(userMessage: "One of the required fields is missing")
            
            return
        }
        
        
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        

       
       
        
        
        let myUrl = URL(string: functions.apiLink()+"app-api/user/login")
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "POST"// Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["username": userName!, "password": userPassword!] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong...")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
            if error != nil
            {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print("error=\(String(describing: error))")
                return
            }
            
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 401{
                    
                    self.displayMessage(userMessage: "Validation failed")
                    print("Validation failed")
                    return
                }
            }
            
            //Let's convert response sent from a server side code to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                let swiftjson = JSON(parseJSON)
                    
                    
                    let accessToken = swiftjson["token"].string
                    let userId = swiftjson["user"]["uid"].string
                    
                    //print("Access token: \(String(describing: accessToken!))")
                    
                    let saveAccesssToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "token")
                    let saveUserId: Bool = KeychainWrapper.standard.set(userId!, forKey: "uid")
                    
                    print("The access token save result: \(saveAccesssToken)")
                    print("The userId save result \(saveUserId)")
                    
                    if (accessToken?.isEmpty)!
                    {
                        // Display an Alert dialog with a friendly error message
                        self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                        return
                    }
                    
                    DispatchQueue.main.async
                        {
                
                            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let Dvc = Storyboard.instantiateViewController(withIdentifier: "KidsTableViewController") as! KidsTableViewController
                            
                            self.navigationController?.pushViewController(Dvc, animated: true)
                    
                       }
                    
                    
                } else {
                    //Display an Alert dialog with a friendly error message
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                }
                
            } catch {
                
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                // Display an Alert dialog with a friendly error message
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print(error)
            }
            
            
            
            
        }
        task.resume()

        
    }

    
//    @IBAction func logout(_ sender: Any) {
//        
//        
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "Accept": "application/json",
//            "X-CSRF-Token": "Tw-uT4vVymr1oDluyuyeI3-wYL6n6ol-u86RNv1NeEs"
//        ]
//        
//        let parameters: Parameters = [:]
//        
//        let url = "http://cre8mania.net/projects/2018/nestleapp/dev/app-api/user/logout"
//        
//        Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON { response in
//            switch response.result {
//            case .success:
//              print(response.result)
//                
//            case .failure(let error):
//                print(error)
//            }
//            
//        }
//    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
    
    
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
    
    
//    func token() {
//
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "Accept": "application/json"
//        ]
//
//        let parameters: Parameters = [:]
//
//        let url = functions.apiLink()+"app-api/user/token"
//
//        Alamofire.request(url, method:.post, parameters:parameters,headers:headers).responseJSON{response in
//
//                switch response.result {
//
//                case .success:
//
//                    if let result = response.result.value{
//
//                        let json = JSON(result)
//                        print(json)
//
//                    }
//
//                case .failure(let error):
//                    print(error)
//            }
//
//            }
//    }
}
    
    

