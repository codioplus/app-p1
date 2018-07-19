//
//  SignupViewController.swift
//  Nestle
//
//  Created by User on 2/28/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import JGProgressHUD
class SignupViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var joinNowTextBtn: RoundBtn!
    @IBOutlet weak var imageView: UIImageView!
    var functions = Functions()

    var imgData: [UIImage] = []
    var nameField:String = ""
    var countryField:String = ""
    var passwordField:String = ""
    var emailField:String = ""
    var contactField:String = ""
    var doctorcodeField:String = ""
    var confirmPasswordField:String = ""
    let hud = JGProgressHUD(style: .light)
    private var embeddedViewController: SignupformTableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SignupformTableView,
            segue.identifier == "EmbedSegue" {
            self.embeddedViewController = vc
        }
    }
    

    
    override func viewDidLoad() {
       super.viewDidLoad()
   
        
        
        
        self.title = ("signupViewTitle").localiz()
        joinNowTextBtn.setTitle(("joinNow").localiz(), for: .normal)

        
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        
        imageView.addGestureRecognizer(tapGesture)
        

        
    }

    @objc func tapGesture(){
        ImageCameraLibrary()
    }
    
    func ImageCameraLibrary(){
        
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: ("Photo_Source").localiz(), message: ("Choose_a_source").localiz(), preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: ("Camera").localiz(), style: .default, handler: {(action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Camera not available")
                
            }
            
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: ("Photo_Library").localiz(), style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: ("cancel").localiz(), style: .cancel, handler: nil ))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
     //   print(info)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
        let image_data = functions.resizeImageWith(image: info[UIImagePickerControllerOriginalImage] as! UIImage , newSize: CGSize(width: 80, height: 80),opaque: true) 
        self.imgData = [image_data]
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    
    
    @IBAction func submitForm(_ sender: Any) {
        
        if self.embeddedViewController.contactField.text != nil{
            self.contactField = self.embeddedViewController.contactField.text!
        }else{
            self.contactField = ""
        }
        
        if self.embeddedViewController.passwordField.text != nil{
            self.passwordField = self.embeddedViewController.passwordField.text!
        }else{
            self.passwordField = ""
        }
    
        if self.embeddedViewController.nameField.text != nil{
            self.nameField = self.embeddedViewController.nameField.text!
        }else{
            self.nameField = ""
        }
    
        if self.embeddedViewController.emailField.text != nil{
            self.emailField = self.embeddedViewController.emailField.text!
        }else{
            self.emailField = ""
        }
        
        if self.embeddedViewController.countryField.text != nil{
            self.countryField = functions.seachCountry(countries: self.embeddedViewController.countries, name: self.embeddedViewController.countryField.text!)
        }else{
            self.countryField = ""
        }
        
        
        if self.embeddedViewController.doctorcodeField.text != nil{
            self.doctorcodeField = self.embeddedViewController.doctorcodeField.text!
        }else{
            self.doctorcodeField = ""
        }
        
        if self.embeddedViewController.confirmPasswordField.text != nil{
            self.confirmPasswordField = self.embeddedViewController.confirmPasswordField.text!
        }else{
            self.confirmPasswordField = ""
        }
        
        
        if self.embeddedViewController.radioBtn.isSelected == false
        {
            
            displayMessage(userMessage: ("Please_accept_terms_and_condition").localiz())
            return
        }
        
        if 
            (doctorcodeField.isEmpty) ||
            (countryField.isEmpty)
             || (passwordField.isEmpty) || (emailField.isEmpty) || (confirmPasswordField.isEmpty)
        {
            // Display Alert message and return
            displayMessage(userMessage: ("All_fields_are_quired_to_fill_in").localiz())
            return
        }
        
        if(nameField.isEmpty){
            nameField = "."
        }
        
        if functions.isValidEmail(email: emailField) == false {
            displayMessage(userMessage: ("Add_a_valid_email").localiz())
            return
            }

        // Validate password
        if ((confirmPasswordField.elementsEqual(passwordField)) != true)
        {
            displayMessage(userMessage: ("Please_make_sure_that_passwords_match").localiz())
            return
        }
        
       
        
        hud.textLabel.text = ("loading").localiz()
        
        hud.show(in: self.view)
        

        
        let parameters = ["user": "Sol" , "password" : "secret1234", "account_type":"5","doctor_id":doctorcodeField,"name": nameField, "country":countryField, "pass":passwordField, "mail":emailField, "contact":contactField]

         let url = functions.apiLink()+"apis/registration.php"

        
     
        Alamofire.upload(multipartFormData: { multipartFormData in
   
            
            
            
            for  fileImage in self.imgData {
                multipartFormData.append(UIImagePNGRepresentation(fileImage)!, withName: "img", fileName: "image.png", mimeType: "image/png")
            }
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        },
                         to: url,
                         method: HTTPMethod(rawValue: "POST")!,
                         encodingCompletion: { encodingResult in
                          
                            switch encodingResult {
                                
                            case .success(let upload, _, _):
                                
                                upload.responseJSON{ response in
                            
                                    
                                    switch response.result {
                                    case .success(let value):
                                        
                                        
                                        let json = JSON(value)
                                        
                                        if json["error"].string != nil{
                                            self.hud.dismiss(afterDelay: 0.5)
                                            self.displayMessage(userMessage: json["error"].string!)
                                            
                                        }else{

                                            self.signInTappedBtn(userNmae: self.emailField, userPassword: self.passwordField)
//                                            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
//                                            let Dvc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//
//                                            self.navigationController?.pushViewController(Dvc, animated: true)
                                        }
                                        
                                        
                                        
                                    case .failure(let error):
                                          self.hud.dismiss(afterDelay: 0.5)
                                         self.displayMessage(userMessage: ("Something_went_wrong._Try_again.").localiz())
                                       // self.displayMessage(userMessage: error as! String)
                                         print(error)
                                    }
                                    
                               
                                    
                                    
                          
                                }
                            case .failure(let encodingError):
                                self.hud.dismiss(afterDelay: 0.5)
                                self.displayMessage(userMessage: ("Something went wrong._Try again.").localiz())
                                print(encodingError)
                            }
        })
        
       

        
        
        

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
                let alertController = UIAlertController(title: ("Alert").localiz(), message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: ("OK").localiz(), style: .default) { (action:UIAlertAction!) in
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

    func signInTappedBtn(userNmae : String , userPassword : String) {
        
        
        print("Sign in button tapped")
        
        // Read values from text fields
        let userName = userNmae
        let userPassword = userPassword
        
        // Check if required fields are not empty
        if (userName.isEmpty) || (userPassword.isEmpty)
        {
             let Storyboard = UIStoryboard(name: "Main", bundle: nil)
             let Dvc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
             self.navigationController?.pushViewController(Dvc, animated: true)
            
            return
        }
        
        
  

        
        let myUrl = URL(string: functions.apiLink()+"app-api/user/login")
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "POST"// Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["username": userName, "password": userPassword] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            self.navigationController?.pushViewController(Dvc, animated: true)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            
            
            if error != nil
            {
                let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                let Dvc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                
                self.navigationController?.pushViewController(Dvc, animated: true)
                return
            }
            
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 401{
                    self.displayMessage(userMessage: ("Validation_failed").localiz())
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
                   
    let account: Bool = KeychainWrapper.standard.set(swiftjson["user"]["field_account_type"]["und"][0]["value"].string!, forKey: "accounttype")
                        
                        
                        
                        
                        print("The account type save result \(account)")
                    }
                    
                    
                    //print(swiftjson)
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
                        self.displayMessage(userMessage: ("Could_not_successfully_perform_this_request._Please_try_again_later").localiz())
                        return
                    }
                    
                    DispatchQueue.main.async
                        {
                            
                            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let Dvc = Storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                            Dvc.firstStart = true
                            self.navigationController?.pushViewController(Dvc, animated: true)
                            
                    }
                   self.hud.dismiss(afterDelay: 0.5)
                    
                } else {
                    
                     self.hud.dismiss(afterDelay: 0.5)
                    let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let Dvc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    
                    self.navigationController?.pushViewController(Dvc, animated: true)
                }
                
            } catch {
                
                 self.hud.dismiss(afterDelay: 0.5)
                let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                let Dvc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                
                self.navigationController?.pushViewController(Dvc, animated: true)
                print(error)
            }
            
            
            
            
        }
        task.resume()
        
        
    }
    
    
}
