//
//  PopupViewController.swift
//  Nestle
//
//  Created by User on 3/29/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import JGProgressHUD

class KidPopupViewController: UIViewController {
    var ayr : String = ""
   var edit : Bool!
   var functions = Functions()
   var  height : String = ""
   var  weight : String = ""
   var  name : String = ""
   var  dateField : String = ""
   var  genderField : String = ""
   var imgData : [UIImage] = []
    
    @IBOutlet weak var close: UIButton!
    
   let momId : String? = KeychainWrapper.standard.string(forKey: "uid")
   var instantOfVCA : ProfileViewController!
   let token : String? = KeychainWrapper.standard.string(forKey: "token")
   let hd = JGProgressHUD(style: .light)
    @IBOutlet weak var addEditChildBtn: UIButton!
    
    @IBOutlet weak var popupContentContainerView: UIView!
    @IBOutlet weak var popupMainView: UIView! {
        didSet {
            popupMainView.layer.cornerRadius = 15
        }
    }
    

    private var addKidViewController : AddKidViewController!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddKidViewController,
            segue.identifier == "addEditKid" {
            self.addKidViewController = vc
        }
    }
    
    
    
    override func viewDidLoad() {
        if self.edit == false{
        self.addEditChildBtn.setTitle(("addchild").localiz(), for: .normal)
        }else{
         self.addEditChildBtn.setTitle(("editchild").localiz(), for: .normal)
        }
        
        
    self.addKidViewController.deleteKid.isHidden = true
         super.viewDidLoad()
     
        self.close.setTitle(("close").localiz(), for: .normal)
        
        if self.edit == true {
            hd.textLabel.text = ("loading").localiz()
            hd.show(in:self.view)
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let ch = UserDefaults.standard.string(forKey: "chi") {
                self.ayr = ch
             //   print("ch: "+ch)
                self.loadprofile(child_id: ch)
                self.addKidViewController.deleteKid.isHidden = false
            }
            
        }
            
            
            
        }else{
            
                 self.addKidViewController.deleteKid.isHidden = true
            
        }
        

        
   modalPresentationCapturesStatusBarAppearance = true
   self.addKidViewController.deleteKid.addTarget(self, action: #selector(deleteKid), for: .touchUpInside)
    }

    
    
    @objc func deleteKid(_ sender: UIButton) {
        
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = ("loading").localiz()
        hud.show(in: self.view)
        
        
        Alamofire.request(functions.apiLink()+"apis/deletekid.php", method: .post, parameters: [
            "child_id": ayr ])
            .validate(statusCode: 200..<300)
            .response { response in
 
                
                if let kid_uid = UserDefaults.standard.string(forKey: "kid_uid"){
                    
                 if   kid_uid == self.ayr {
                        UserDefaults.standard.set("", forKey: "kid_uid")
                        UserDefaults.standard.set("", forKey: "kid_name")
                        UserDefaults.standard.set("", forKey: "kid_age")
                        
                    }
                    
                }else{
                    
                    
                    UserDefaults.standard.set("", forKey: "kid_uid")
                    UserDefaults.standard.set("", forKey: "kid_name")
                    UserDefaults.standard.set("", forKey: "kid_age")
                    
                }

                
                
                
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                    UIView.animate(withDuration: 0.3) {
                        hud.indicatorView = nil
                        hud.textLabel.font = UIFont.systemFont(ofSize: 18.0)
                        
                        hud.textLabel.text = ("Deleted").localiz()
                        hud.position = .bottomCenter
                    }
                }
                self.instantOfVCA.collectionView.reloadData()
                hud.dismiss(afterDelay: 2.0)
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2500)) {
                    self.dismiss(animated: true)
                    
                }
        }
        
      DataManager.shared.profile.collectionView.reloadData()
    }
    
    
    
    
    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        
  
        dismiss(animated: true)
    }
    
    
    @IBAction func addEditKid(_ sender: UIButton) {
        
        

        
        
        if self.addKidViewController.height.text != nil{
            self.height = self.addKidViewController.height.text!
        }else{
            self.height = ""
        }
        
        if self.addKidViewController.weight.text != nil{
            self.weight = self.addKidViewController.weight.text!
        }else{
            self.weight = ""
        }
        
        if self.addKidViewController.name.text != nil{
            self.name = self.addKidViewController.name.text!
        }else{
            self.name = ""
        }
        
        if self.addKidViewController.dateField.text != nil{
      
            let dateString = self.addKidViewController.dateField.text!
            let reqDate = dateString.toDateString(inputDateFormat: "dd/MM/yyyy", ouputDateFormat: "yyyy-MM-dd HH:mm:ss")
            self.dateField = String(describing: reqDate)
                
                
            
        }else{
            self.dateField = ""
        }
        
        if self.addKidViewController.genderField.text != nil{
            self.genderField = self.addKidViewController.genderField.text!
        }else{
            self.genderField = ""
        }
        
        

        
        if height.isEmpty ||
          weight.isEmpty ||
          name.isEmpty ||
          dateField.isEmpty ||
          genderField.isEmpty
        {
            
        self.displayMessage(userMessage: ("All_fields_are_quired_to_fill_in").localiz())

            
        } else{
            
            
         height  = self.addKidViewController.height.text!
         weight  = self.addKidViewController.weight.text!
         name  =   self.addKidViewController.name.text!
         //dateField = self.addKidViewController.dateField.text!
         genderField = self.addKidViewController.genderField.text!

        }
        
        self.imgData = self.addKidViewController.imgData
        
        
        
        


        
        
        if edit == false {
            
        
            
            let act = JGProgressHUD(style: .light)
            act.textLabel.text = ("loading").localiz()
            act.show(in: self.view)
            
            let parameters = [
                "mother_id": momId!,
                "kid_name" : "\(name)",
                "kid_dob" : "\(dateField)",
                "kid_height" : "\(height)",
                "kid_weight": "\(weight)",
                "gender" : "\(genderField)"
            ]
            
            let url = functions.apiLink()+"apis/addkid.php"
            
            
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
                                                
                                                self.displayMessage(userMessage: json["error"].string!)
                                                 act.dismiss(afterDelay: 0.5)
                                            }else{
                                             //   print(json)
                                                

                                                
                                                print("success")

                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                                                    UIView.animate(withDuration: 0.3) {
                                                        act.indicatorView = nil
                                                        act.textLabel.font = UIFont.systemFont(ofSize: 18.0)
                                                        act.textLabel.text = ("Added").localiz()
                                                        act.position = .bottomCenter
                                                    }
                                                }
                                                
                                                act.dismiss(afterDelay: 2.0)
                                                 self.instantOfVCA.collectionView.reloadData()
                                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2500)) {
                                                    
                                                    self.dismiss(animated: true)
                                                }
                                                
                                            }
                                            
                                            
                                            
                                        case .failure(let error):
                                            act.dismiss(afterDelay: 0.5)
                                            self.displayMessage(userMessage: ("Something_went_wrong._Try_again.").localiz())
                                            // self.displayMessage(userMessage: error as! String)
                                            print(error)
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                    }
                                case .failure(let encodingError):
                                    act.dismiss(afterDelay: 0.5)
                                    self.displayMessage(userMessage: ("Something_went_wrong._Try_again.").localiz())
                                    print(encodingError)
                                }
            })
            
            
            
            
        }else{
            
         
            
            let act = JGProgressHUD(style: .light)
            act.textLabel.text = ("loading").localiz()
            act.show(in: self.view)
            
            let parameters = [
                "mother_id": momId!,
                "kid_name" : "\(name)",
                "kid_age" : "\(dateField)",
                "kid_height" : "\(height)",
                "kid_weight": "\(weight)",
                "gender" : "\(genderField)",
                "child_id" : ayr
            ]
            
            
            
            
            print(parameters)
            let url = functions.apiLink()+"apis/editkid.php"
            
            
            
            
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
                                                act.dismiss(afterDelay: 0.5)
                                                self.displayMessage(userMessage: json["error"].string!)
                                                
                                            }else{
                                               // print(json)
                                                print("success")
                                           
                                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                                                    UIView.animate(withDuration: 0.3) {
                                                        act.indicatorView = nil
                                                        act.textLabel.font = UIFont.systemFont(ofSize: 18.0)
                                                        act.textLabel.text = ("Edited").localiz()
                                                        act.position = .bottomCenter
                                                    }
                                                }
                                                
                                                act.dismiss(afterDelay: 2.0)
                                                self.instantOfVCA.collectionView.reloadData()
                                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2500)) {
                                                    
                                                    self.dismiss(animated: true)
                                                }
                                                
                                            }
                                            
                                            
                                            
                                        case .failure(let error):
                                            act.dismiss(afterDelay: 0.5)
                                            self.displayMessage(userMessage: ("Something_went_wrong._Try_again.").localiz())
                                            // self.displayMessage(userMessage: error as! String)
                                            print(error)
                                        }
                                        
                                        
                                        
                                        
                                        
                                    }
                                case .failure(let encodingError):
                                    act.dismiss(afterDelay: 0.5)
                                    self.displayMessage(userMessage: ("Something_went_wrong._Try_again.").localiz())
                                    print(encodingError)
                                }
            })
            
            
            
        }
            
 DataManager.shared.profile.collectionView.reloadData()
    }
    
 
    func loadprofile(child_id : String ){
        
        
        //  let token : String? = KeychainWrapper.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
          
            ]
        
       // let parameters: Parameters = [:]
        
        let url = functions.apiLink()+"app-api/node/"+child_id
        
        Alamofire.request(url, method:.get, headers:headers).responseJSON {response in
            switch response.result {
            case .success:
                if let values = response.result.value {
                    
                let json = JSON(values)
  
                  self.addKidViewController.height.text = json["field_height"]["und"][0]["value"].string
                  self.addKidViewController.weight.text = json["field_weight"]["und"][0]["value"].string
                  self.addKidViewController.name.text  = json["title"].string
                  let ageKid = json["field_age"]["und"][0]["value"].string
                  self.addKidViewController.dateField.text = ageKid?.toDateString(inputDateFormat: "yyyy-MM-dd HH:mm:ss", ouputDateFormat: "dd/MM/yyyy")
                    
                  self.addKidViewController.genderField.text = json["field_gender"]["und"][0]["name"].string?.capitalized
                    
                    
                    if let imageUrl = URL(string: json["field_profile_image"]["und"][0]["value"].stringValue){
                        self.addKidViewController.imageView.kf.setImage(with: imageUrl)
  
                    }
                      self.hd.dismiss(afterDelay:0.5)
                }
                else{
                      self.hd.dismiss(afterDelay:0.5)
                    print("no data")
                }
            case .failure(let error):
                print(error)
                
                  self.hd.dismiss(afterDelay:0.5)
            }
            
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


extension KidPopupViewController: MIBlurPopupDelegate {
    
    var popupView: UIView {
        return popupContentContainerView ?? UIView()
    }
    
    
    
    
    var blurEffectStyle: UIBlurEffectStyle {
        
        return .dark
    }
    
    var initialScaleAmmount: CGFloat {
        return 0.7
    }
    
    var animationDuration: TimeInterval {
        return 0.5
    }
    
}


extension String
{
    func toDateString( inputDateFormat inputFormat  : String,  ouputDateFormat outputFormat  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date!)
    }
}



