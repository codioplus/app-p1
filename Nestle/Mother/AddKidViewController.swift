//
//  AddKidViewController.swift
//  Nestle
//
//  Created by User on 4/18/18.
//  Copyright © 2018 Nestle. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import ActionSheetPicker_3_0

class AddKidViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate ,
//UIPickerViewDelegate, UIPickerViewDataSource,
UITextFieldDelegate{
    var imgData: [UIImage] = []
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var deleteKid: UIButton!
    
    @IBOutlet weak var provide_detail: UILabel!
    @IBOutlet weak var kg: UILabel!
    @IBOutlet weak var cm: UILabel!
    // var mainpop = KidPopupViewController()
    
    
    var functions = Functions()
    
    
//    let datePicker = UIDatePicker()
//
//    var myPickerView : UIPickerView!
//    var pickerData = ["Male" , "Female" ]
//
//    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
//        return 1
//    }
//
//    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
//
//        return self.pickerData.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//       return pickerData[row]
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        genderField.text = self.pickerData[row]
//
//    }
//
//
//    @objc func doneClick() {
//     genderField.resignFirstResponder()
//    }
//    @objc func cancelClick() {
//   genderField.resignFirstResponder()
//    }
//
//
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
        @IBAction func hidekeyboardInTouch(_ sender: UITextField) {
            view.endEditing(true)
        }
    
    

    
    @IBAction func dateAddEdit(_ sender: UITextField) {
        
                self.view.endEditing(true)
        
        let datePicker = ActionSheetDatePicker(title: "", datePickerMode: UIDatePickerMode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            self.dateField.text = formatter.string(from: value as! Date)
            
          
            print("value = \(value!)")
            print("index = \(index!)")
            print("picker = \(picker!)")
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)
        let secondsInWeek: TimeInterval = 0 * 24 * 60 * 60;
       // datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
        datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
        
        datePicker?.show()
    }
    
    
    
    
    @IBAction func genderEditBegin(_ sender: UITextField) {
        print("tttttappp")
        self.view.endEditing(true)
        
        ActionSheetStringPicker.show(withTitle: "", rows: [("male").localiz(), ("female").localiz()], initialSelection: 0, doneBlock: {
            picker, value, index in
            self.genderField.text = index as? String
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
        
        
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        height.delegate = self
        weight.delegate = self
        name.delegate = self
        dateField.delegate = self
        genderField.delegate = self
        
        
        if functions.lang() == "ar"{
            
            
            height.textAlignment = .right
            weight.textAlignment = .right
            name.textAlignment = .right
            dateField.textAlignment = .right
            genderField.textAlignment = .right
            
        }

        self.height.placeholder = ("weight").localiz()
        self.weight.placeholder = ("height").localiz()
        self.name.placeholder = ("kid_name").localiz()
        self.dateField.placeholder = ("date_birth").localiz()
        
        self.genderField.placeholder = ("gender").localiz()
        self.deleteKid.setTitle(("deleteKid").localiz(), for: .normal)
        
        self.provide_detail.text = ("provide_detail").localiz()
        self.kg.text = ("kg").localiz()
        self.cm.text = ("cm").localiz()
        
        
//        pickUp(genderField)


        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        
        imageView.addGestureRecognizer(tapGesture)
    
//        showDatePicker()
    }
    
    @objc func tapGesture(){
        ImageCameraLibrary()
    }
 

    func ImageCameraLibrary(){
        
        
      let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: ("Photo_Source").localiz(), message: ("Choose_a_source").localiz(), preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: ("Camera").localiz(), style: .default, handler: {(action:UIAlertAction) in
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
          
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }else{
            print("Camera not available")
            
        }
     
    }))
        
   
    actionSheet.addAction(UIAlertAction(title: ("Photo_Library").localiz(), style: .default, handler: {(action:UIAlertAction) in
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
      actionSheet.addAction(UIAlertAction(title: ("cancel").localiz(), style: .cancel, handler: nil ))
        
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
    
//    func showDatePicker(){
//        //Formate Date
//        datePicker.datePickerMode = .date
//
//        //ToolBar
//        let toolbar = UIToolbar();
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
//
//        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: true)
//
//        dateField.inputAccessoryView = toolbar
//        dateField.inputView = datePicker
//
//    }
//
//    @objc func donedatePicker(){
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd/MM/yyyy"
//        dateField.text = formatter.string(from: datePicker.date)
//        self.view.endEditing(true)
//    }
//
//    @objc func cancelDatePicker(){
//        self.view.endEditing(true)
//    }

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    

//    func pickUp(_ textField : UITextField){
//
//        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
//        self.myPickerView.delegate = self
//        self.myPickerView.dataSource = self
//        self.myPickerView.backgroundColor = UIColor.white
//        textField.inputView = self.myPickerView
//
//        let toolBar = UIToolbar()
//        toolBar.barStyle = .default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
//        toolBar.sizeToFit()
//
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//        textField.inputAccessoryView = toolBar
//
//    }
    
    
    
}
