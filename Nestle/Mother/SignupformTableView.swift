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

class SignupformTableView: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{

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
    
    @IBOutlet weak var and: UILabel!
    @IBOutlet weak var radioBtn: DLRadioButton!
    
    @IBOutlet weak var privacy_btn: UIButton!
    @IBOutlet weak var term_of_use: UIButton!
    @IBOutlet weak var cookies: UIButton!
    @IBOutlet weak var i_accept: UILabel!
    
    @IBOutlet weak var topTerm: NSLayoutConstraint!
    var pickerView = UIPickerView()


    
    let functions = Functions()
    
    var countries : [[String : Any]] = []

   
    override func viewDidLoad() {

     super.viewDidLoad()
        

        
        self.i_accept.text = ("i_accept").localiz()
        self.privacy_btn.setTitle(("privacy_btn").localiz(), for: .normal)
        self.cookies.setTitle(("cookies").localiz(), for: .normal)
        self.term_of_use.setTitle(("term_of_use").localiz(), for: .normal)
        self.and.text = ("and").localiz()
        
        
      nameLabelSignup.text = ("nameLabelSignup").localiz()
      emailLabelSignup.text = ("emailLabelSignup").localiz()
      countryLabelSignup.text = ("countryLabelSignup").localiz()
      contactLabelSignup.text = ("contactLabelSignup").localiz()
      doctorCodeLabelSignup.text = ("doctorCodeLabelSignup").localiz()
      passwordLabelSignup.text = ("passwordLabelSignup").localiz()
      confirmPasswordLabelSignup.text = ("confirmPasswordLabelSignup").localiz()
        
        if functions.lang() == "ar"{
            
           topTerm.constant = 11
            self.term_of_use.layoutIfNeeded()
            
            
            nameField.textAlignment = .right
            emailField.textAlignment = .right
            contactField.textAlignment = .right
            doctorcodeField.textAlignment = .right
            confirmPasswordField.textAlignment = .right
            passwordField.textAlignment = .right
            countryField.textAlignment = .right
            
            
            
        }
        
        

        nameField.delegate = self
        emailField.delegate = self
        contactField.delegate = self
        doctorcodeField.delegate = self
        confirmPasswordField.delegate = self
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

  override  func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(false)
        countriesList()
    }
    
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
    
    
    
    
}
