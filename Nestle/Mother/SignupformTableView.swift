//
//  SignupformTableView.swift
//  Nestle
//
//  Created by User on 3/1/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class SignupformTableView: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var nameLabelSignup: UILabel!
    @IBOutlet weak var emailLabelSignup: UILabel!
    @IBOutlet weak var countryLabelSignup: UILabel!
    @IBOutlet weak var contactLabelSignup: UILabel!
    @IBOutlet weak var doctorCodeLabelSignup: UILabel!
    @IBOutlet weak var passwordLabelSignup: UILabel!
    @IBOutlet weak var confirmPasswordLabelSignup: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var contactField: UITextField!
    @IBOutlet weak var doctorcodeField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    
    var pickerView = UIPickerView()

    let functions = Functions()
    
    var countries : [[String : Any]] = []

   
    override func viewDidLoad() {

     super.viewDidLoad()
        
  
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
 
        
      nameLabelSignup.text = NSLocalizedString("nameLabelSignup", comment: "Name (optional)")
      emailLabelSignup.text = NSLocalizedString("emailLabelSignup", comment: "Email")
      countryLabelSignup.text = NSLocalizedString("countryLabelSignup", comment: "Country of residence")
      contactLabelSignup.text = NSLocalizedString("contactLabelSignup", comment: "Contact (optional)")
      doctorCodeLabelSignup.text = NSLocalizedString("doctorCodeLabelSignup", comment: "Enter doctor code")
      passwordLabelSignup.text = NSLocalizedString("passwordLabelSignup", comment: "Password")
      confirmPasswordLabelSignup.text = NSLocalizedString("confirmPasswordLabelSignup", comment: "Confirm Password")
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        countryField.inputView = pickerView
        //countryField.textAlignment = .center
        //countryField.placeholder = "select country"
    }
    
   
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{

        return self.countries.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  self.countries[row]["name_en"] as? String
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryField.text = self.countries[row]["name_en"] as? String
        countryField.resignFirstResponder()
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   
        self.view.endEditing(true)
     
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
//    func myMethod(){
//        
//        print ("qqq")
//    }
}

