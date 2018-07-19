//
//  MotherMenuViewController.swift
//  Nestle
//
//  Created by User on 4/25/18.
//  Copyright © 2018 Nestle. All rights reserved.
//
import Darwin
import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import SideMenu
class MotherMenuViewController: UIViewController {
    var accounttype : String?
    var selectedLanguage:Languages?
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mail: UILabel!
    
    @IBOutlet weak var cookies: UIButton!
    @IBOutlet weak var term_of_use: UIButton!
    @IBOutlet weak var privacy_btn: UIButton!
    
    @IBOutlet weak var sign_out: UIButton!
    
    @IBOutlet weak var ar: UILabel!
    @IBOutlet weak var en: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    var lang : String?
    @IBOutlet weak var profile_open: UIView!
    
    
    
    //    "privacy_btn" = "سياسة الخصوصية";
//    "cookies" = "الكوكيز وتقنيات التتبع الاخرى";
//    "term_of_use" = "شروط الاستخدام";
    
let functions = Functions()
    
    
    
    
    @IBAction func terms_use(_ sender: UIButton) {
        

        
        UserDefaults.standard.set("3", forKey: "termId")
      
            self.privacy_btn.sendActions(for: .touchUpInside)
        
    }
    
    
    @IBAction func cookies_notice(_ sender: UIButton) {


        UserDefaults.standard.set("1", forKey: "termId")

      self.privacy_btn.sendActions(for: .touchUpInside)
        
    }
    
    
    @IBAction func privacy_notice(_ sender: UIButton) {

    
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
        
   
      
        self.navigationController?.popToViewController(Dvc, animated: true)
        
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(false)
     
        if let imageUrlString = KeychainWrapper.standard.string(forKey: "profile_image"){
            
            if let imageUrl = URL(string: imageUrlString){
                do{
                    
                    profile_image.kf.setImage(with: imageUrl)
                    
                }
            }
        }
        
        if let nameVal = KeychainWrapper.standard.string(forKey: "name") {
            name.text =   nameVal
        }
        if let mailVal = KeychainWrapper.standard.string(forKey: "mail") {
            mail.text  = mailVal
        }
    }
    
    
    
    @IBAction func `switch`(_ sender: UISwitch) {
        
        if(sender.isOn == true){
            SideMenuManager.default.menuRightNavigationController?.dismiss(animated: false, completion: nil)
         //   UIFont.overrideInitialize()
            selectedLanguage = .ar
            
            lang = "ar"
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            self.en.text = "عر"
            self.ar.text = "EN"
            
            
            
            
        }else{
            
            SideMenuManager.default.menuLeftNavigationController?.dismiss(animated: false, completion: nil)
        //    UILabel.appearance().font = UIFont(name: "Gotham", size: UIFont.labelFontSize)
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
        
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
//        
     
        DispatchQueue.main.async
            {
            
            
       //     let delegate = UIApplication.shared.delegate as! AppDelegate
        //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
       //     delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
            
        
            let alertController = UIAlertController(title: ("attention").localiz(), message: ("restart").localiz(), preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: ("OK").localiz(), style: UIAlertActionStyle.cancel, handler: {
                (action:UIAlertAction!) -> Void in
                exit (0)
              //  UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
            }))
            
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindowLevelAlert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
            
            
            
        }
        
        
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accounttype = KeychainWrapper.standard.string(forKey: "accounttype")!
        self.ar.semanticContentAttribute = .forceLeftToRight
        self.en.semanticContentAttribute = .forceLeftToRight
        self.`switch`.semanticContentAttribute = .forceLeftToRight
        
        
        self.cookies.setTitle(("cookies").localiz(), for: .normal)
        self.term_of_use.setTitle(("term_of_use").localiz(), for: .normal)
        self.privacy_btn.setTitle(("privacy_btn").localiz(), for: .normal)
        self.sign_out.setTitle(("sign_out").localiz(), for: .normal)

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(double_tapped))
        tap.numberOfTapsRequired = 1
        profile_open.addGestureRecognizer(tap)
        
        
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
        
        if let imageUrlString = KeychainWrapper.standard.string(forKey: "profile_image"){
            
            if let imageUrl = URL(string: imageUrlString){
                do{
                    
                   profile_image.kf.setImage(with: imageUrl)
                    
                }
            }
        }
        
        if let nameVal = KeychainWrapper.standard.string(forKey: "name") {
        name.text =   nameVal
        }
         if let mailVal = KeychainWrapper.standard.string(forKey: "mail") {
        mail.text  = mailVal
        }
        
    }

    
    @objc func double_tapped() {

        if self.accounttype == "5"{
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.navigationController?.pushViewController(Dvc, animated: true)
        }else{
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let Dvc = Storyboard.instantiateViewController(withIdentifier: "ProfileDoctorViewController") as! ProfileDoctorViewController
            self.navigationController?.pushViewController(Dvc, animated: true)
            return
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signoutBtn(_ sender: Any) {
        

        if  let token: String = KeychainWrapper.standard.string(forKey: "token"){
            
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
                   //   print(response.result)
                      
                      KeychainWrapper.standard.removeObject(forKey: "token")
                      UserDefaults.standard.removeObject(forKey: "token")
                        
                      DispatchQueue.main.async
                        {
                            
                            
                                UserDefaults.standard.removeObject(forKey: "kid_uid")
              
                        
                                UserDefaults.standard.removeObject(forKey: "kid_name")
                    
                                UserDefaults.standard.removeObject(forKey: "kid_age")
                                    
                         
                            
                            
                            
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

