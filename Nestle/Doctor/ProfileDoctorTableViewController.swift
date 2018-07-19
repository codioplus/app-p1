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
import DLRadioButton

class ProfileDoctorTableView: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var careerLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var hospitalLabel: UILabel!
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var contactField: UITextField!
    @IBOutlet weak var careerField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var hospitalField: UITextField!
  

    var pickerView = UIPickerView()
    
    
    
    let functions = Functions()
    
    var countries : [[String : Any]] = []
    
    
    
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        countriesList()
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if functions.lang()  == "ar"{
            self.countryField.textAlignment = LanguageManger.shared.isRightToLeft ? .right : .left
            
        }

        
        
        nameLabel.text = ("name_doc").localiz()
        emailLabel.text = ("email_doc").localiz()
        countryLabel.text = ("country_doc").localiz()
        contactLabel.text = ("contact_doc").localiz()
        careerLabel.text = ("career_doc").localiz()
        passwordLabel.text = ("password_doc").localiz()
        hospitalLabel.text = ("hospital_doc").localiz()
        


        
        nameField.delegate = self
        emailField.delegate = self
        contactField.delegate = self
        careerField.delegate = self
        hospitalField.delegate = self
        passwordField.delegate = self
        countryField.delegate = self
        
        
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

