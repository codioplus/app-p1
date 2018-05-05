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
    
    private var embeddedViewController: SignupformTableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SignupformTableView,
            segue.identifier == "EmbedSegue" {
            self.embeddedViewController = vc
        }
    }
    
    //  Now in other methods you can reference `embeddedViewController`.
    //  For example:
//    override func viewDidAppear(_ animated: Bool) {
//      print(self.embeddedViewController.myMethod())
//        
//    }
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
   
        
        
        
        self.title = NSLocalizedString("signupViewTitle", comment: "sign up")
        joinNowTextBtn.setTitle(NSLocalizedString("joinNow", comment: "Join now"), for: .normal)

        
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        
        imageView.addGestureRecognizer(tapGesture)
        
        
        
//
//        let currentUser = backendless.userService.currentUser
//        let pictureURL = currentUser.getProperty("picture")
//        let url = NSURL(string: pictureURL as! String)
//        data = NSData(contentsOfURL:url!)
//        if data != nil {
//            profileImage?.image = UIImage(data:data! as Data)
//        }
        
        
        
        
    }

    @objc func tapGesture(){
        ImageCameraLibrary()
    }
    
    func ImageCameraLibrary(){
        
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Camera not available")
                
            }
            
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
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
        
        
        if (contactField.isEmpty) ||
            (doctorcodeField.isEmpty) ||
            (countryField.isEmpty) ||
            (nameField.isEmpty) || (passwordField.isEmpty) || (emailField.isEmpty) || (confirmPasswordField.isEmpty)
        {
            // Display Alert message and return
            displayMessage(userMessage: "All fields are quired to fill in")
            return
        }
        
        if functions.isValidEmail(email: emailField) == false {
                displayMessage(userMessage: "Add a valid email")
                return
            }
        
        
        
        
        // Validate password
        if ((confirmPasswordField.elementsEqual(passwordField)) != true)
        {
            // Display alert message and return
            displayMessage(userMessage: "Please make sure that passwords match")
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
        

        
        let parameters = ["user": "Sol" , "password" : "secret1234", "account_type":"5","doctor_id":doctorcodeField,"name": nameField, "country":countryField, "pass":passwordField, "mail":emailField, "contactField":contactField]

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
                                  self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                                upload.responseJSON{ response in
                            
                                    
                                    switch response.result {
                                    case .success(let value):
                                        
                                        
                                        let json = JSON(value)
                                        
                                        if json["error"].string != nil{
                                            
                                            self.displayMessage(userMessage: json["error"].string!)
                                            
                                        }else{

                                            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                                            let Dvc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                                            
                                            self.navigationController?.pushViewController(Dvc, animated: true)
                                        }
                                        
                                        
                                        
                                    case .failure(let error):
                                         self.displayMessage(userMessage: "Something went wrong. Try again.")
                                       // self.displayMessage(userMessage: error as! String)
                                         print(error)
                                    }
                                    
                               
                                    
                                    
                          
                                }
                            case .failure(let encodingError):
                                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                                self.displayMessage(userMessage: "Something went wrong. Try again.")
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

    
}
