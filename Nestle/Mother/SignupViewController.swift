//
//  SignupViewController.swift
//  Nestle
//
//  Created by User on 2/28/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var joinNowTextBtn: RoundBtn!
    @IBOutlet weak var imageView: UIImageView!


    
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
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    
    
    @IBAction func submitForm(_ sender: Any) {
        
        if self.embeddedViewController.contactField.text != nil{
            let contactField = self.embeddedViewController.contactField.text
        }else{
            let contactField = ""
        }
        
        if self.embeddedViewController.passwordField.text != nil{
            let passwordField = self.embeddedViewController.passwordField.text
        }else{
            let passwordField = ""
        }
    
        if self.embeddedViewController.nameField.text != nil{
            let nameField = self.embeddedViewController.nameField.text
        }else{
            let nameField = ""
        }
    
        if self.embeddedViewController.emailField.text != nil{
            let emailField = self.embeddedViewController.emailField.text
        }else{
            let emailField = ""
        }
        
        if self.embeddedViewController.countryField.text != nil{
            let countryField = self.embeddedViewController.countryField.text
        }else{
            let countryField = ""
        }
        
        print (self.embeddedViewController.countries)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
