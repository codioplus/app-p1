//
//  LoginViewController.swift
//  Nestle
//
//  Created by User on 2/27/18.
//  Copyright © 2018 Nestle. All rights reserved.
//
import Darwin
import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class LoginViewController: UIViewController, UITextFieldDelegate {

    let functions = Functions()
    var selectedLanguage:Languages?
    
    @IBOutlet weak var usernameField: TextfieldBorderBottom!
    @IBOutlet weak var passwordField: TextfieldBorderBottom!
    @IBOutlet weak var notUserText: UILabel!
    @IBOutlet weak var signUpBtnText: UIButton!
    @IBOutlet weak var loginBtnText: RoundBtn!
    @IBOutlet weak var ar: UILabel!
    @IBOutlet weak var en: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    var lang : String?
    
    
    var tok:String = ""
    let signUpBtnTextAttributes : [NSAttributedStringKey: Any] = [
        NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
    
    override func viewDidLoad() {
  
    super.viewDidLoad()

    usernameField.textAlignment  =  LanguageManger.shared.isRightToLeft ? .right : .left
    passwordField.textAlignment  =  LanguageManger.shared.isRightToLeft ? .right : .left
        self.ar.semanticContentAttribute = .forceLeftToRight
        self.en.semanticContentAttribute = .forceLeftToRight
        self.`switch`.semanticContentAttribute = .forceLeftToRight
     usernameField.delegate = self;
     passwordField.delegate = self;
        
        
        if let lg = UserDefaults.standard.string(forKey: "lang"){
            
            if lg == "ar"{
                self.switch.isOn = true
                   self.en.text = "عر"
                self.ar.text = "EN"
            }else{
                self.switch.isOn = false
                self.ar.text = "عر"
                self.en.text = "EN"
            }
            
        }
        
        
    usernameField.placeholder = ("placeholderUsernameField").localiz()
        
    passwordField.placeholder = ("placeholderPasswordField").localiz()
  
    notUserText.text = ("notUserLabelText").localiz()
   
    loginBtnText.setTitle(("loginBtn").localiz(), for: .normal)
        
        
    let attributeString = NSMutableAttributedString(string: ("signUpBtnText").localiz(),attributes: signUpBtnTextAttributes)
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
                    
                 //   print(swiftjson)
                    let accessToken = swiftjson["token"].string
                    let userId = swiftjson["user"]["uid"].string
                    let mail = swiftjson["user"]["mail"].string
                    let name = swiftjson["user"]["field_name"]["und"][0]["value"].string
                    let profile_image = swiftjson["user"]["field_profile_image_user"]["und"][0]["value"].string
                    let country = swiftjson["user"]["field_country_of_residence"]["und"][0]["tid"].string
                    if swiftjson["user"]["field_account_type"]["und"].count > 0{
                        
                        print("accountType")
                        
                      
                        
                        let account: Bool = KeychainWrapper.standard.set(swiftjson["user"]["field_account_type"]["und"][0]["value"].string!, forKey: "accounttype")
                        
                        
                        
                        print("The account type save result \(account) \(swiftjson["user"]["field_account_type"]["und"][0]["value"].string!)")
                        
                        
                    }
                    
                    
                 //   print(swiftjson)
                   // print("yala")
                  //  print(swiftjson["user"]["field_doctor_name"]["und"].arrayValue[0]["value"])
                 //   print(swiftjson["user"]["field_doctor_name"]["und"][0]["value"])
                  
                    let saveAccesssToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "token")
                    
                    
                    UserDefaults.standard.set(accessToken!, forKey: "token")
                    
                     if let nm = name {
                    KeychainWrapper.standard.set(nm, forKey: "name")
                    }
                    
                    if let profileImage = profile_image {
                    KeychainWrapper.standard.set(profileImage, forKey: "profile_image")
                    }else{
                     KeychainWrapper.standard.set("", forKey: "profile_image")
                    }
                    
                    if let cn = country {
                        KeychainWrapper.standard.set(cn, forKey: "country_id")
                    }
            
                    
                    
                    KeychainWrapper.standard.set(mail!, forKey: "mail")
                    let saveUserId: Bool = KeychainWrapper.standard.set(userId!, forKey: "uid")
                    
                    if swiftjson["user"]["field_doctor_code"]["und"].count > 0{
                    if let field_doctor_code = swiftjson["user"]["field_doctor_code"]["und"].arrayValue[0]["uid"].string{
          
                        let doctor_id: Bool = KeychainWrapper.standard.set(field_doctor_code, forKey: "doctor_id")
                        print("The doctor id save result \(doctor_id)")
                        if swiftjson["user"]["field_doctor_name"]["und"].count > 0{
                        if let doctor_name = swiftjson["user"]["field_doctor_name"]["und"].arrayValue[0]["value"].string{
                            let doctor: Bool = KeychainWrapper.standard.set(doctor_name, forKey: "doctor_name")
                            print("The doctor name save result \(doctor)")
                        }
                    }
                    }
                    }

                    
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
                
                            if swiftjson["user"]["field_account_type"]["und"].count > 0{
                                if swiftjson["user"]["field_account_type"]["und"][0]["value"].string! == "4"{
                                    let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let Dvc = Storyboard.instantiateViewController(withIdentifier: "HomeDoctorViewController") as! HomeDoctorViewController
                                    
                                    self.navigationController?.pushViewController(Dvc, animated: true)
                                    
                                }else{
                                    
                                    let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let Dvc = Storyboard.instantiateViewController(withIdentifier: "KidsTableViewController") as! KidsTableViewController
                                    
                                    self.navigationController?.pushViewController(Dvc, animated: true)
                                    
                                    
                                }
                            }
                            
                            
                            

                    
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

    
    @IBAction func `switch`(_ sender: UISwitch) {
        
        if(sender.isOn == true){
            
          
          //  UIFont.overrideInitialize()
           
            selectedLanguage = .ar
            
         lang = "ar"
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            self.en.text = "عر"
            self.ar.text = "EN"
        }else{
          //  UILabel.appearance().font = UIFont(name: "Gotham", size: UIFont.labelFontSize)
            lang = "en"
         selectedLanguage = .en
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            self.ar.text = "عر"
            self.en.text = "EN"
        }
       // print("tffffooo")
      //  print(lang)
        UserDefaults.standard.set(lang!, forKey: "lang")
        
        // change the language
        LanguageManger.shared.setLanguage(language: selectedLanguage!)

//            let delegate = UIApplication.shared.delegate as! AppDelegate
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//            delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
//
//
        
 
        
        DispatchQueue.main.async
            {
      
            
                    //    let delegate = UIApplication.shared.delegate as! AppDelegate
                   //     let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
                  //      delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
            
            
            let alertController = UIAlertController(title: ("attention").localiz(), message: ("restart").localiz(), preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: ("OK").localiz(), style: UIAlertActionStyle.cancel, handler: {
                (action:UIAlertAction!) -> Void in
                exit(0)
              //  UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
            }))
            
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindowLevelAlert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
        }

        
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
    
    

