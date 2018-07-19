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
import SideMenu
class ProfileDoctorViewController : UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var joinNowTextBtn: RoundBtn!
    @IBOutlet weak var imageView: UIImageView!
    var functions = Functions()
    
    var imgData: [UIImage] = []
    
    var nameField:String = ""
    var emailField:String = ""
    var contactField:String = ""
    var careerField:String = ""
    var hospitalField:String = ""
    var passwordField:String = ""
    var countryField:String = ""
   // var country_id : String = ""
    var momId = String()
    let hd = JGProgressHUD(style: .light)
    let hud = JGProgressHUD(style: .light)
    
    private var profileView: ProfileDoctorTableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ProfileDoctorTableView,
            segue.identifier == "EmbedSegue22" {
            self.profileView = vc
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        hd.textLabel.text = ("loading").localiz()
        hd.show(in:self.view)
        
        
        
        // self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = ("profile").localiz()
        joinNowTextBtn.setTitle(("save").localiz(), for: .normal)
        
        
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        
        imageView.addGestureRecognizer(tapGesture)
        
        
        
        
        
        
        
        self.momId = KeychainWrapper.standard.string(forKey: "uid")!
        let token : String? = KeychainWrapper.standard.string(forKey: "token")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "X-CSRF-Token": token!,
                ]
            

            
            let url = self.functions.apiLink()+"app-api/user/"+self.momId
            
            Alamofire.request(url,  headers:headers).responseJSON{
                response in
            
                switch response.result {
                case .success:
                    
                    if let values = response.result.value {
                       // print(values)
                        let   json = JSON(values)
                        
                       // print(json)
                        if json["field_name"].count > 0{
                            self.profileView.nameField.text = json["field_name"]["und"][0]["value"].string
                            
                            self.hd.dismiss(afterDelay:0.5)
                        }else{
                            
                            if  let token: String = KeychainWrapper.standard.string(forKey: "token"){
                                
                                let headers: HTTPHeaders = [
                                    "Content-Type": "application/json",
                                    "Accept": "application/json",
                                    "X-CSRF-Token": token
                                ]
                                
                                let parameters: Parameters = [:]
                                
                                let url = self.functions.apiLink()+"app-api/user/logout"
                                
                                Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON { response in
                                    switch response.result {
                                    case .success:
                                      //  print(response.result)
                                        
                                        KeychainWrapper.standard.removeObject(forKey: "token")
                                        
                                        
                                        DispatchQueue.main.async
                                            {
                                                
                                                let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                let Dvc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                                                
                                                self.navigationController?.pushViewController(Dvc, animated: true)
                                                
                                        }
                                        
                                    case .failure(let error):
                                        print(error)
                                        self.hd.dismiss(afterDelay:0.5)
                                    }
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                        if json["mail"] != ""{
                            self.profileView.emailField.text = json["mail"].string
                        }
                        
                        if json["field_country_of_residence"].count > 0{
                           // self.country_id = json["field_country_of_residence"]["und"][0]["tid"].string!
                            if self.functions.lang() == "ar" {
                                self.profileView.countryField.text = json["field_country_name_ar"]["und"][0]["value"].string
                            }else{
                                self.profileView.countryField.text = json["field_country_name"]["und"][0]["value"].string
                            }
                            
                        }
                        
                        if json["field_contact"].count > 0{
                            self.profileView.contactField.text = json["field_contact"]["und"][0]["value"].string
                        }
                        
                        
                        if json["field_career"].count > 0{
                            self.profileView.careerField.text = json["field_career"]["und"][0]["value"].string
                        }
                        
                        
                        if json["field_hospital"].count > 0{
                            self.profileView.hospitalField.text = json["field_hospital"]["und"][0]["value"].string
                        }
                        
                       
                        if json["field_profile_image_user"].count > 0{
                            
                            
                            if let imageUrl = URL(string: json["field_profile_image_user"]["und"][0]["value"].stringValue){
                                self.imageView.kf.setImage(with: imageUrl)
                                
                                // self.profileView.imageView.image = #imageLiteral(resourceName: "1")
                                
                                
                            }
                        }
                        
                        
                        
                        
                    }
                    else{
                        
                        print("no data")
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    
                    
                }
            
        
            }
        }
        
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
        
        actionSheet.addAction(UIAlertAction(title:  ("cancel").localiz(), style: .cancel, handler: nil ))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
      //  print(info)
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
        

        
   
        if self.profileView.contactField.text != nil{
            self.contactField = self.profileView.contactField.text!
        }else{
            self.contactField = "";
        }
        
        if self.profileView.passwordField.text != nil{
            self.passwordField = self.profileView.passwordField.text!
        }else{
            self.passwordField = "";
        }
        
        if self.profileView.nameField.text != nil{
            self.nameField = self.profileView.nameField.text!
        }else{
            self.nameField = "";
        }
        
        if self.profileView.careerField.text != nil{
            self.careerField = self.profileView.careerField.text!
        }else{
            self.careerField = "";
        }
        
        if self.profileView.hospitalField.text != nil{
            self.hospitalField = self.profileView.hospitalField.text!
        }else{
            self.hospitalField = "";
        }
        
        
        if self.profileView.countryField.text != nil{
            self.countryField = functions.seachCountry(countries: self.profileView.countries, name: self.profileView.countryField.text!)
        }else{
            self.countryField = ""
        }
        //print(self.profileView.countries)
      //  print(contactF+"_"+countryF+"_"+nameF)
        
        
        if (nameField.isEmpty)
        {
            displayMessage(userMessage: ("All_fields_are_quired_to_fill_in").localiz())
            return
        }
        

        
        
        let parameters = ["uid" : self.momId , "name" : nameField, "country" : countryField, "pass" : passwordField, "mail" : emailField, "contact" : contactField, "hospital" : hospitalField, "career" : careerField]
       // print(parameters)
        let url = functions.apiLink()+"apis/edit_registration.php"
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = ("loading").localiz()
        hud.show(in: self.view)
        
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
                                            hud.dismiss(afterDelay: 0)
                                            self.displayMessage(userMessage: json["error"].string!)
                                            
                                        }else{
                                           // print(json)
                                            
                                            
                                            
                                            KeychainWrapper.standard.set(self.nameField, forKey: "name")
                                            
                                            
                                            if let profileImage = json["profile_image"].string {
                                                KeychainWrapper.standard.set(profileImage, forKey: "profile_image")
                                            }else{
                                                KeychainWrapper.standard.set("", forKey: "profile_image")
                                            }
                                            
                                            
                                            KeychainWrapper.standard.set(self.countryField , forKey: "country_id")
                                            
                                            
                                            
                                            
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                                                UIView.animate(withDuration: 0.3) {
                                                    hud.indicatorView = nil
                                                    hud.textLabel.font = UIFont.systemFont(ofSize: 18.0)
                                                    
                                                    hud.textLabel.text = ("Done").localiz()
                                                    hud.position = .bottomCenter
                                                }
                                            }
                                            
                                            
                                            hud.dismiss(afterDelay: 2.0)
                                        }
                                        
                                        
                                        
                                    case .failure(let error):
                                        hud.dismiss(afterDelay: 0)
                                        self.displayMessage(userMessage: ("Something_went_wrong._Try_again.").localiz())
                                        
                                        print(error)
                                    }
                                    
                                    
                                    
                                    
                                    
                                }
                            case .failure(let encodingError):
                                hud.dismiss(afterDelay: 0)
                                self.displayMessage(userMessage: ("Something_went_wrong._Try_again.").localiz())
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
    
    
    
    @IBAction func openRightMenu(_ sender: UIBarButtonItem) {
        
        if functions.lang() == "ar"{
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        }else{
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        }
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
 
    
    
    
    
}

