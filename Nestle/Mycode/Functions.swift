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
        if let langCode = Locale.current.languageCode{
            lang = langCode
        }
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
    let menuRightNavigationController = Storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController") as! UISideMenuNavigationController
    SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
    
    SideMenuManager.default.menuAddPanGestureToPresent(toView: controller.navigationController!.navigationBar)
    SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: controller.navigationController!.view)

}
    

    

    

}


