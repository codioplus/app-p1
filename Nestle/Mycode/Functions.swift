//
//  Functions.swift
//  Nestle
//
//  Created by User on 4/25/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import Foundation
import UIKit
import SideMenu
import Alamofire
import SwiftyJSON
class Functions{


    
    
    
func isValidEmail(email:String?) -> Bool {
    
    guard email != nil else { return false }
    
    let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
    print(pred.evaluate(with: email))
    return pred.evaluate(with: email)
}

    func lang() -> String{
        var lang = "en"
      
            lang = LanguageManger.shared.currentLanguage.rawValue
        
        return lang
    }
    
    func resizeImageWith(image: UIImage, newSize: CGSize,opaque: Bool) -> UIImage {
        print("width")
        print(image.size.width)
        print("height")
        print(image.size.height)
        print(newSize.width)
             print(newSize.height)
        let horizontalRatio = newSize.width / image.size.width
        let verticalRatio = newSize.height / image.size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: image.size.width * ratio, height: image.size.height * ratio)
        var newImage: UIImage
        
        if #available(iOS 10.0, *) {
            let renderFormat = UIGraphicsImageRendererFormat.default()
            renderFormat.opaque = false
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: newSize.width, height: newSize.height), format: renderFormat)
            newImage = renderer.image {
                (context) in
                image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: newSize.width, height: newSize.height), opaque, 0)
            image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        
        return newImage
    }
    
    func seachCountry( countries : [[String : Any]],name : String ) -> String{
    
        for country in countries{
            
          //  print(country)
            if self.lang() == "ar"{
            //    print("ar")
                if name == country["name_ar"] as! String {
                return country["id"] as! String
                }
                
            }else{
                print("en")
                if name == country["name_en"] as! String {
                    return country["id"] as! String
                }
                
            }
   
        }
        
        return ""
    }
    
    
    func downloadImage(_ uri : String, inView: UIImageView){
        
        let url = URL(string: uri)
        
        let task = URLSession.shared.dataTask(with: url!) {responseData,response,error in
            if error == nil{
                if let data = responseData {
                    
                    DispatchQueue.main.async {
                        inView.image = UIImage(data: data)
                    }
                    
                }else {
                    print("no data")
                }
            }else{
                print(error)
            }
        }
        
        task.resume()
        
    }
    
func isValidPassword(testStr:String?) -> Bool {
    guard testStr != nil else { return false }
    
    // at least one uppercase,
    // at least one digit
    // at least one lowercase
    // 8 characters total
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
    return passwordTest.evaluate(with: testStr)
}
    
    func apiLink() -> String {
        return "http://cre8mania.net/projects/2018/nestleapp/dev/"
    }
    

    func menuRight(controller:UIViewController){
    
    controller.navigationItem.setHidesBackButton(true, animated:true);
        
   let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if self.lang() == "ar"{
      
    let menuRightNavigationController = Storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController") as! UISideMenuNavigationController
    SideMenuManager.default.menuLeftNavigationController = menuRightNavigationController
        }else{
            
            let menuRightNavigationController = Storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController") as! UISideMenuNavigationController
            SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
            
        }
        
   // SideMenuManager.default.menuWidth = 200
    SideMenuManager.default.menuAddPanGestureToPresent(toView: controller.navigationController!.navigationBar)
    SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: controller.navigationController!.view)

}
    
   
    func accurateRound(value: Double) -> Int {
        
        let d : Double = value - Double(Int(value))
        
        if d < 0.5 {
            return Int(value)
        } else {
            return Int(value) + 1
        }
    }
    
    


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

    
    
    func numberOfSections(in tableView: UITableView, data : Int)
    {
        let noDataLabel : UILabel!
        
        if data > 0
        {

            tableView.backgroundView = nil
        }
        else
        {
           
            noDataLabel   = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = ("no_data_available").localiz()
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.separatorStyle  = .none
            tableView.backgroundView  = noDataLabel
            noDataLabel.isHidden = false
        }
      //  return numOfSections
    }
   
    func numberOfSectionsCollection(in collectionView: UICollectionView, data : Int)
    {
        let noDataLabel : UILabel!
        
        if data > 0
        {
            
            collectionView.backgroundView = nil
        }
        else
        {
            
            noDataLabel   = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
            noDataLabel.text          = ("no_data_available").localiz()
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
          //  tableView.separatorStyle  = .none
            collectionView.backgroundView  = noDataLabel
            noDataLabel.isHidden = false
        }
        //  return numOfSections
    }
    

    
    
}
