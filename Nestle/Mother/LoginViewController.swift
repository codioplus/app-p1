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

    @IBOutlet weak var usernameField: TextfieldBorderBottom!
    @IBOutlet weak var passwordField: TextfieldBorderBottom!
    @IBOutlet weak var notUserText: UILabel!
    @IBOutlet weak var signUpBtnText: UIButton!
    @IBOutlet weak var loginBtnText: RoundBtn!
    
    var tok:String = ""
    let signUpBtnTextAttributes : [NSAttributedStringKey: Any] = [
        NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
    
    override func viewDidLoad() {
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
       
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        
        self.present(registerViewController, animated:true)
    
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
        
        
        //Send HTTP Request to perform Sign in
        let myUrl = URL(string: "http://cre8mania.net/projects/2018/nestleapp/dev/app-api/user/login")

        
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
            
            if let httpResponse = response as? HTTPURLResponse{

                print ("Status Code: \(httpResponse.statusCode)")
                
                
                let headers: HTTPHeaders = [
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                ]
                
                let parameters: Parameters = [:]
                
                let url = "http://cre8mania.net/projects/2018/nestleapp/dev/app-api/user/token"
                
                Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON { response in
                    switch response.result {
                    case .success:
                        //debugPrint(response)
                        if let result = response.result.value{
                            
                            let json = JSON(result)
                            print(json["token"])
                         self.tok = "\(json["token"])"
                        }
                        
                      //  tok = response.result.value
                    case .failure(let error):
                        print(error)
                    }
                    
                }
                
            }

            if error != nil
            {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print("error=\(String(describing: error))")
                return
            }
 
            
            //Let's convert response sent from a server side code to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
//                    if parseJSON["errorMessageKey"] != nil
//                    {
//                        self.displayMessage(userMessage: parseJSON["errorMessage"] as! String)
//                        return
//                    }
                    // Now we can access value of First Name by its key
                    let accessToken = parseJSON["token"] as? String
                    //let userId = parseJSON["user"]["uid"] as? String
                    //print("Access token: \(String(describing: accessToken!))")
                    
//                    let saveAccesssToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "accessToken")
//                    let saveUserId: Bool = KeychainWrapper.standard.set(userId!, forKey: "userId")
//
//                    print("The access token save result: \(saveAccesssToken)")
//                    print("The userId save result \(saveUserId)")
                    
                    print(parseJSON)
                    
                    
                    
                    if (accessToken?.isEmpty)!
                    {
                        // Display an Alert dialog with a friendly error message
                        self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                        return
                    }
                    
                    DispatchQueue.main.async
                        {
//                            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
//                            let appDelegate = UIApplication.shared.delegate
//                            appDelegate?.window??.rootViewController = homePage
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
    
    
    
    
    @IBAction func logout(_ sender: Any) {
        
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "X-CSRF-Token": tok
        ]
        
        let parameters: Parameters = [:]
        
        let url = "http://cre8mania.net/projects/2018/nestleapp/dev/app-api/user/logout"
        
        Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON { response in
            switch response.result {
            case .success:
                debugPrint(response)
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
    
}
