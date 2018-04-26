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
    return pred.evaluate(with: email)
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


