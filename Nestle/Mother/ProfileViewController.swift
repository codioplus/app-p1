//
//  ProfileViewController.swift
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
import SideMenu
import PromiseKit
class ProfileViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate , UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var my_children: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    let functions = Functions()
    var imgData: [UIImage] = []
    @IBOutlet weak var imageView: UIImageView!
    private var profileView : EditProfileTableViewController!
    var kids = [Kids]()
    var imgData2: [UIImage]?
    let hd = JGProgressHUD(style: .light)
    var countryF = ""
    var nameF = ""
    var contactF = ""
    var emailF = ""
    var passwordF = ""
    var country_id = ""
    var momId = String()
    var firstStart : Bool?
    
    var timer : Timer?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
   
        if let vc = segue.destination as? EditProfileTableViewController,
            segue.identifier == "EmbedSegue2" {
            self.profileView = vc
        }

        if segue.identifier == "contentSegue1" {


            if let nextViewController = segue.destination as? KidPopupViewController{
                nextViewController.edit = true
                nextViewController.instantOfVCA = self
            
            }
        }

        if segue.identifier == "contentSegue2" {
            if let nextViewController = segue.destination as? KidPopupViewController{
                nextViewController.edit = false
                nextViewController.instantOfVCA = self
                
            }
        }
        
        
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
        self.imgData2 = [image_data]
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.kids.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == kids.count  {
        
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! KidCollectionViewCell
        cell2.add_kid.addTarget(self, action: #selector(addkid(_:)), for: UIControlEvents.touchUpInside)
            
            if self.firstStart == true{
               // DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                cell2.add_kid.sendActions(for: .touchUpInside)
                    
            
                    
              //  }
            }
            
            
     
        return cell2
        
        }
        else
        {
            
            
     let kid : Kids = kids[indexPath.row]
        
        
        
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! KidCollectionViewCell
            
            cell.kidImage.layer.cornerRadius = 40
            cell.kidImage.layer.borderWidth = 3
            
            if kid.gender == "female"{
                
                cell.kidImage.layer.borderColor =  #colorLiteral(red: 0.9607843137, green: 0.4784313725, blue: 0.5098039216, alpha: 1)
            }else{
                cell.kidImage.layer.borderColor = #colorLiteral(red: 0.3647058824, green: 0.7098039216, blue: 0.6431372549, alpha: 1)
            }
            

        
        if let imageUrlString = kid.profile_image{
            
            if let imageUrl = URL(string: imageUrlString){

               // let data = try? Data(contentsOf: imageUrl)
                //let img = UIImage(data: data!)

                cell.kidImage.kf.setImage(with: imageUrl, for: .normal)
                
                cell.kidImage.imageView?.contentMode = UIViewContentMode.scaleAspectFill
            }
            else{
                
                cell.kidImage.setImage(UIImage(named: "no_profile.png"), for: .normal)
            }
            
            
        }
        else{
            
            cell.kidImage.setImage(UIImage(named: "no_profile.png"), for: .normal)
            }
            
            
            
            
            cell.kidImage.tag = Int(kid.child_id!)!
            
   cell.kidImage.addTarget(self, action: #selector(editkid), for: UIControlEvents.touchUpInside)

            
            
//            let tapGesture = MyTapGesture(target: self, action: #selector(editkid(_:)))
//            cell.profileKid.addGestureRecognizer(tapGesture)
//            tapGesture.childId = kid.child_id!
//
//            cell.profileKid.isUserInteractionEnabled = true
            
            
            
        return cell
        }

    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        print("selecrt")
//
//        print(self.kids[indexPath.row])
//
//         if indexPath.row == kids.count  {
//            self.performSegue(withIdentifier: "contentSegue2", sender: indexPath)
//         }else{
//
//           self.performSegue(withIdentifier: "contentSegue1", sender: self.kids[indexPath.row].child_id)
//        }
//    }
    
    

    
    
    @objc func addkid(_ sender: Any){
        self.firstStart = false
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "KidPopupViewController") as! KidPopupViewController
        Dvc.edit = false
        self.navigationController?.popToViewController(Dvc, animated: true)

    }
    
    
    
    @objc func editkid(_ sender: Any) {
        
        let store = (sender as AnyObject).tag

 UserDefaults.standard.set(store!, forKey: "chi")
        
  

        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "KidPopupViewController") as! KidPopupViewController
    
      
         Dvc.edit = true
        self.navigationController?.popToViewController(Dvc, animated: true)
        
    
    }
    
  
    
    @IBOutlet weak var kidsCollection: UICollectionView!
    
    @objc func reloadCollection(){
        
        self.kids = [Kids]()
        
        let momId = self.momId
        let URL_GET_DATA = functions.apiLink()+"get_mom_kids.json/"+momId
        Alamofire.request(URL_GET_DATA).responseJSON { response in
            
            //getting json
            if let json = response.result.value {
                
                //converting json to NSArray
                let kidsArray : NSArray  = json as! NSArray
                
                //traversing through all elements of the array
                for i in 0..<kidsArray.count{
                    
                    //adding hero values to the hero list
                    self.kids.append(Kids(
                        title: (kidsArray[i] as AnyObject).value(forKey: "title") as? String,
                        dob: (kidsArray[i] as AnyObject).value(forKey: "dob") as? String,
                        profile_image: (kidsArray[i] as AnyObject).value(forKey: "profile_image") as? String,
                        child_id: (kidsArray[i] as AnyObject).value(forKey: "child_id") as? String,
                        gender: (kidsArray[i] as AnyObject).value(forKey: "gender") as? String
                    ))
                    
                }
            
            }
             self.collectionView.reloadData()
        }
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
 
        super.viewDidDisappear(false)
        stopTimer()
    }
    
    
    func stopTimer(){
        self.timer?.invalidate()
        self.timer = nil
    }
    
    
    
    override func viewDidLoad() {
        

        super.viewDidLoad()
        
        self.my_children.text = ("my_children").localiz()
        hd.textLabel.text = ("loading").localiz()
        hd.show(in:self.view)
     
        DataManager.shared.profile = self
        functions.menuRight(controller: self)
        self.momId = KeychainWrapper.standard.string(forKey: "uid")!
        let token : String? = KeychainWrapper.standard.string(forKey: "token")
         self.profileView.submitProfile.addTarget(self, action: #selector(editProfile(_:)), for: .touchUpInside)
         self.title = ("editProfilePageTitle").localiz()
        self.profileView.countriesList()
        
       self.loadKids(momId: self.momId)
        
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {

            
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "X-CSRF-Token": token!,
            ]
            
      //    print("70c")
      //  print(token)
       // print(self.momId)
          //print("70c")
            
            let url = self.functions.apiLink()+"app-api/user/"+self.momId
        
        Alamofire.request(url,  headers:headers).responseJSON{
            response in
           // print(response.result)
            switch response.result {
            case .success:
                
                if let values = response.result.value {
                        print(values)
                    let   json = JSON(values)
                    
                    print(json)
                    if json["field_name"].count > 0{
                       self.profileView.nameLabelProfile.text = json["field_name"]["und"][0]["value"].string
                        
                    self.hd.dismiss(afterDelay:0.5)
                    }else{
                        
                        if  let token: String = KeychainWrapper.standard.string(forKey: "token"){
                            
                            let headers: HTTPHeaders = [
                                "Content-Type": "application/json",
                                "Accept": "application/json",
                                "X-CSRF-Token": token
                            ]
                            
                            let parameters: Parameters = [:]
                            
                            let url = self.functions.apiLink()+"app-api/user/logout"
                            
                            Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON { response in
                                switch response.result {
                                case .success:
                               //     print(response.result)
                                    
                                    KeychainWrapper.standard.removeObject(forKey: "token")
                                    
                                    
                                    DispatchQueue.main.async
                                        {
                                            
                                            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                                            let Dvc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                                            
                                            self.navigationController?.pushViewController(Dvc, animated: true)
                                           
                                    }
                                    
                                case .failure(let error):
                                    print(error)
                                       self.hd.dismiss(afterDelay:0.5)
                                }
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    if json["mail"] != ""{
                     self.profileView.emailLabelProfile.text = json["mail"].string
                    }
                    
                    if json["field_country_of_residence"].count > 0{
                        
                        if self.functions.lang() == "ar" {
                           self.profileView.countryField.text = json["field_country_name_ar"]["und"][0]["value"].string
                        }else{
                          self.profileView.countryField.text = json["field_country_name"]["und"][0]["value"].string
                        }
                     
                    }
                    
                    if json["field_contact"].count > 0{
                        self.profileView.contactField.text = json["field_contact"]["und"][0]["value"].string
                    }
                 //   print(json)
                    if json["field_profile_image_user"].count > 0{
                        
                        
                        if let imageUrl = URL(string: json["field_profile_image_user"]["und"][0]["value"].stringValue){
                         self.imageView.kf.setImage(with: imageUrl)
                                
                               // self.profileView.imageView.image = #imageLiteral(resourceName: "1")
                                
                           
                        }
                    }
                    
                    
                    
                    
                }
                else{
                    
                    print("no data")
                }
                
                
            case .failure(let error):
                print(error)
                
                
            }
        }
    }
        
               self.timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(reloadCollection), userInfo: nil, repeats: true)
        
        
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        
        imageView.addGestureRecognizer(tapGesture)
    }

    
   @objc func loadKids(momId: String){
        
        
        
        
        let URL_GET_DATA = functions.apiLink()+"get_mom_kids.json/"+momId
        Alamofire.request(URL_GET_DATA).responseJSON { response in
            
            //getting json
            if let json = response.result.value {
                
                //converting json to NSArray
                let kidsArray : NSArray  = json as! NSArray
                
                //traversing through all elements of the array
                for i in 0..<kidsArray.count{
                    
                    //adding hero values to the hero list
                    self.kids.append(Kids(
                        title: (kidsArray[i] as AnyObject).value(forKey: "title") as? String,
                        dob: (kidsArray[i] as AnyObject).value(forKey: "dob") as? String,
                        profile_image: (kidsArray[i] as AnyObject).value(forKey: "profile_image") as? String,
                        child_id: (kidsArray[i] as AnyObject).value(forKey: "child_id") as? String,
                        gender: (kidsArray[i] as AnyObject).value(forKey: "gender") as? String
                    ))
                    
                }
                
                self.collectionView.reloadData()
                
        
            }
            
        }
        
    }
 
    
    
    
    @objc func editProfile(_ sender: UIButton) {

        
        if self.profileView.contactField.text != nil{
            self.contactF = self.profileView.contactField.text!
        }else{
            self.contactF = "";
        }
        
        if self.profileView.passwordField.text != nil{
            self.passwordF = self.profileView.passwordField.text!
        }else{
            self.passwordF = "";
        }
        
        if self.profileView.nameLabelProfile.text != nil{
            self.nameF = self.profileView.nameLabelProfile.text!
        }else{
            self.nameF = "";
        }
        
        
        
        if self.profileView.countryField.text != nil{
            self.countryF = functions.seachCountry(countries: self.profileView.countries, name: self.profileView.countryField.text!)
        }else{
            self.countryF = ""
        }
       // print(self.profileView.countries)
       // print(contactF+"_"+countryF+"_"+nameF)
        
        if (countryF.isEmpty) || (nameF.isEmpty)
        {
            displayMessage(userMessage:("All_fields_are_quired_to_fill_in").localiz())
            return
        }
        
        
        
        let parameters = ["uid" : self.momId , "name" : nameF, "country" : countryF, "pass" : passwordF, "mail" : emailF, "contact" : contactF]
     //   print(parameters)
        let url = functions.apiLink()+"apis/edit_registration.php"
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = ("loading").localiz()
        hud.show(in: self.view)
        
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
                                            hud.dismiss(afterDelay: 0)
                                            self.displayMessage(userMessage: json["error"].string!)
                                            
                                        }else{
                                          //  print(json)
                                            
                                            
                                            
                                                KeychainWrapper.standard.set(self.nameF, forKey: "name")
                                     
                                            
                                            if let profileImage = json["profile_image"].string {
                                                KeychainWrapper.standard.set(profileImage, forKey: "profile_image")
                                            }else{
                                                KeychainWrapper.standard.set("", forKey: "profile_image")
                                            }
                                            
                                          
                                                KeychainWrapper.standard.set(self.countryF , forKey: "country_id")
                                            
                                            
                                            
                                            
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                                                UIView.animate(withDuration: 0.3) {
                                                    hud.indicatorView = nil
                                                    hud.textLabel.font = UIFont.systemFont(ofSize: 18.0)
                                                    
                                                    hud.textLabel.text = ("Done").localiz()
                                                    hud.position = .bottomCenter
                                                }
                                            }
                                            
                                            
                                            hud.dismiss(afterDelay: 2.0)
                                        }
                                        
                                        
                                        
                                    case .failure(let error):
                                        hud.dismiss(afterDelay: 0)
                                        self.displayMessage(userMessage: ("Something_went_wrong._Try_again.").localiz())
                                        
                                        print(error)
                                    }
                                    
                                    
                                    
                                    
                                    
                                }
                            case .failure(let encodingError):
                                hud.dismiss(afterDelay: 0)
                                self.displayMessage(userMessage:("Something_went_wrong._Try_again.").localiz())
                                print(encodingError)
                            }
        })
        
        
    }
    
    

    @IBAction func openRightMenu(_ sender: UIBarButtonItem) {
        
        if functions.lang() == "ar"{
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        }else{
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
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


