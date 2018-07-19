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

class SendShoutPopupViewController : UIViewController {
   var functions = Functions()
    var  tit : String = ""
    var  body : String = ""
   
    var imgData : [UIImage] = []
    
    let momId : String? = KeychainWrapper.standard.string(forKey: "uid")
 
    @IBOutlet weak var save: UIButton!
    
    @IBOutlet weak var close: UIButton!
    @IBOutlet weak var shout_save: UIButton!
    @IBOutlet weak var popupContentContainerView: UIView!
    @IBOutlet weak var popupMainView: UIView! {
        didSet {
            popupMainView.layer.cornerRadius = 15
        }
    }
    
    
    private var addKidViewController : SendShoutViewController!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SendShoutViewController,
            segue.identifier == "addShoutout" {
            self.addKidViewController = vc
        }
    }
    
    
    
    override func viewDidLoad() {
        
   
      
       super.viewDidLoad()
        
self.close.setTitle(("close").localiz(), for: .normal)
self.save.setTitle(("save_shout").localiz(), for: .normal)

    }
    
    
    
    
    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        
        
        dismiss(animated: true)
    }
    
    
    @IBAction func addShout(_ sender: UIButton) {
        
        
        
        
        
        if self.addKidViewController.shoutTitle.text != nil{
            self.tit = self.addKidViewController.shoutTitle.text!
        }else{
            self.tit = ""
        }
        
        if self.addKidViewController.shoutBody.text != nil{
            self.body = self.addKidViewController.shoutBody.text!
        }else{
            self.body = ""
        }
     
        
        
        if tit.isEmpty ||
            body.isEmpty
        {
            
            self.displayMessage(userMessage: ("All_fields_are_quired_to_fill_in").localiz())
            
            
        } else{
            
            
            tit  = self.addKidViewController.shoutTitle.text!
            body  = self.addKidViewController.shoutBody.text!

        }
        
        self.imgData = self.addKidViewController.imgData
        
        
  
            
            let act = JGProgressHUD(style: .light)
            act.textLabel.text = ("loading").localiz()
            act.show(in: self.view)
            
            let parameters = [
                "doctor_id": momId!,
                "body" : body,
                "title" : tit
            ]
            
            let url = functions.apiLink()+"apis/shoutout.php"
            
            
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
                                               // print(json)
                                                
                                                
                                                
                                                print("success")
                                                
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                                                    UIView.animate(withDuration: 0.3) {
                                                        act.indicatorView = nil
                                                        act.textLabel.font = UIFont.systemFont(ofSize: 18.0)
                                                        act.textLabel.text = "Added"
                                                        act.position = .bottomCenter
                                                    }
                                                }
                                                
                                                act.dismiss(afterDelay: 2.0)
                                                
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


extension SendShoutPopupViewController : MIBlurPopupDelegate {
    
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






