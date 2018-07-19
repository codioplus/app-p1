//
//  EditProfileTableViewController.swift
//  Nestle
//
//  Created by User on 5/12/18.
//  Copyright © 2018 Nestle. All rights reserved.
//


    
    import UIKit
    import Alamofire
    import SwiftyJSON
    import SwiftKeychainWrapper
    import Kingfisher
    import JGProgressHUD


    class EditProfileTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
       
        @IBOutlet weak var nameLabelProfile: UITextField!
        @IBOutlet weak var emailLabelProfile: UITextField!
        @IBOutlet weak var countryField: UITextField!
        @IBOutlet weak var contactField: UITextField!
        @IBOutlet weak var nameLabelSignup: UILabel!
        @IBOutlet weak var emailLabelSignup: UILabel!
        @IBOutlet weak var countryLabelSignup: UILabel!
        @IBOutlet weak var contactLabelSignup: UILabel!
        @IBOutlet weak var newPasswordLabel: UILabel!
        @IBOutlet weak var passwordField: UITextField!
        @IBOutlet weak var submitProfile: UIButton!
        
        let functions = Functions()
        var countries : [[String : Any]] = []
        var momId = String()
        var pickerView = UIPickerView()
        
        
        private var profileViewController : ProfileViewController!
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? ProfileViewController,
                segue.identifier == "EmbedSegue2" {
                self.profileViewController = vc
            }
        }
        
        
        
     

        
        override func viewDidLoad() {
            super.viewDidLoad()

            
            
            
            nameLabelSignup.text = ("nameLabelSignup").localiz()
            emailLabelSignup.text = ("emailLabelSignup").localiz()
            countryLabelSignup.text = ("countryLabelSignup").localiz()
            contactLabelSignup.text = ("contactLabelSignup").localiz()
            newPasswordLabel.text = ("newPasswordLabel").localiz()
            
            submitProfile.setTitle(("submit").localiz(), for: .normal)
            
            nameLabelProfile.delegate = self
            emailLabelProfile.delegate = self
            countryField.delegate = self
            contactField.delegate = self
            passwordField.delegate = self
           
            
            if functions.lang() == "ar"{
                
                nameLabelProfile.textAlignment = .right
                emailLabelProfile.textAlignment = .right
                countryField.textAlignment = .right
                contactField.textAlignment = .right
                passwordField.textAlignment = .right
                
            }
            
            
            
            
            pickerView.delegate = self
            pickerView.dataSource = self
            countryField.inputView = pickerView
            momId = KeychainWrapper.standard.string(forKey: "uid")!
        }
        
        
        public func numberOfComponents(in pickerView: UIPickerView) -> Int{
            return 1
        }
        
        public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
            
            return self.countries.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if functions.lang() == "ar"{
                return self.countries[row]["name_ar"] as? String
            }else{
                return self.countries[row]["name_en"] as? String
            }
            // return self.countries[row]["name_en"] as? String
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            if functions.lang() == "ar"{
                countryField.text = self.countries[row]["name_ar"] as? String
            }else{
                countryField.text = self.countries[row]["name_en"] as? String
            }
            countryField.resignFirstResponder()
        }
        
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
        

        func countriesList(){
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "Accept": "application/json",
                ]
            
            let parameters: Parameters = [:]
            
            let url = functions.apiLink()+"countries.json"
            
            Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON {response in
                switch response.result {
                case .success:
                    
                    if let values = response.result.value  as! [[String: Any]]? {
                        
                        self.countries = values
                        
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

