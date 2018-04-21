//
//  SignupformTableView.swift
//  Nestle
//
//  Created by User on 3/1/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit

class SignupformTableView: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource{

  
    @IBOutlet weak var nameLabelSignup: UILabel!
    @IBOutlet weak var emailLabelSignup: UILabel!
    @IBOutlet weak var countryLabelSignup: UILabel!
    @IBOutlet weak var contactLabelSignup: UILabel!
    @IBOutlet weak var doctorCodeLabelSignup: UILabel!
    @IBOutlet weak var passwordLabelSignup: UILabel!
    @IBOutlet weak var confirmPasswordLabelSignup: UILabel!
    
    @IBOutlet weak var countryField: UITextField!
    var pickerView = UIPickerView()

    
    let countries = ["Lebanon","Syria", "London", "Jorden", "USA"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        return countries.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryField.text = countries[row]
        countryField.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
