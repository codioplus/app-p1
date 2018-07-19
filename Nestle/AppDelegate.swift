  //
//  AppDelegate.swift
//  Nestle
//
//  Created by User on 2/27/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
  
import Tune
import AdSupport
import CoreSpotlight
import CoreTelephony
import iAd
import MobileCoreServices
import QuartzCore
import Security
import StoreKit
import SystemConfiguration
import UserNotifications
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
  
  var appFontName       = "Tahoma"
  var appFontBoldName   = "Tahoma-Bold"

  
  extension UIFont {
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: appFontName, size: size)!
    }
    
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: appFontBoldName, size: size)!
    }
    

    
    @objc convenience init(myCoder aDecoder: NSCoder) {
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            if let fontAttribute = fontDescriptor.fontAttributes[UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")] as? String {

                var fontName = ""
                switch fontAttribute {
                case "Gotham-Book", "Gotham-Medium":
                    fontName = appFontName
                    //-Bold", "Gotham-Black
                case "Gotham":
                    fontName = appFontBoldName
               
                default:
                    fontName = appFontName
                }
                self.init(name: fontName, size: fontDescriptor.pointSize)!
            }
            else {
                
                
                 let fontName = appFontName
                 self.init(name: fontName, size: fontDescriptor.pointSize)!
               // self.init(myCoder: aDecoder)
            }
        }
        else {
            self.init(myCoder: aDecoder)
        }
    }
    
    class func overrideInitialize() {
  
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod!, mySystemFontMethod!)
            
            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod!, myBoldSystemFontMethod!)

            
            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))) // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
            method_exchangeImplementations(initCoderMethod!, myInitCoderMethod!)
        }
    }
  }
  

  
  
@UIApplicationMain
  class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
   
//    override init() {
//        super.init()
//        UIFont.overrideInitialize()
//    }
    
    var window: UIWindow?
//    var lastEvent: SWNotification?
//    var currentEvent: SWNotification?
//    var action: SWAction?
//    var smartwhere: SmartWhere!
//
        let functions = Functions()
    
  //  let Tune_Advertiser_Id   = "your Tune Advertiser ID"
  //  let Tune_Conversion_Key  = "your Tune Conversion Key"
//    let Tune_Package_Name = "your Package Name - should match Tune TMC settings"
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        LanguageManger.shared.defaultLanguage = .en
        
        

      if functions.lang() == "ar"{
          //  UILabel.appearance().font = UIFont(name: "Tahoma", size: UIFont.labelFontSize)
            UIFont.overrideInitialize()
        }
       

   
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .normal)
        // Set navigation bar ItemButton tint colour
        //UIBarButtonItem.appearance().tintColor = UIColor.yellow
         if functions.lang() == "ar"{
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white , NSAttributedStringKey.font: UIFont(name: "Tahoma-Bold", size: 17)!]
         }else{
            
         UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white , NSAttributedStringKey.font: UIFont(name: "Gotham-Bold", size: 17)!]
        }
        // Set Navigation bar background image
        let navBgImage:UIImage = UIImage(named: "navbar.png")!
        UINavigationBar.appearance().setBackgroundImage(navBgImage, for: .default)
        
        //Set navigation bar Back button tint colour
        UINavigationBar.appearance().tintColor = UIColor.white
        
        

        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
//        window?.rootViewController = KidsTableViewController()
        
  
//                    let Storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let Dvc = Storyboard.instantiateViewController(withIdentifier: "StarterViewController") as! StarterViewController
//
//                    self.window?.rootViewController = Dvc
        
        
 
        
//        if let saved_token : String = KeychainWrapper.standard.string(forKey: "token"){
//            print(saved_token)
//
//
//             let navigationController = UINavigationController(rootViewController: KidsTableViewController())
//            self.window?.rootViewController = navigationController
//            self.window?.makeKeyAndVisible()
//
//
//        }else{
//
//            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let Dvc = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//
//            self.window?.rootViewController = Dvc
//        }
        
        
        
        
        // Note: to set self as the delegate, this class needs to implement the TuneDelegate protocol
    //    Tune.setDelegate(self)
        
        // call one of the Tune init methods
      //  Tune.initialize(withTuneAdvertiserId: Tune_Advertiser_Id, tuneConversionKey: Tune_Conversion_Key)
        
        
        // Note: only for debugging
     //   Tune.setDebugMode(false)
        
        // Register this class as a deeplink listener to handle deferred deeplinks and Tune Universal Links.
        // This class must conform to the TuneDelegate protocol, implementing the tuneDidReceiveDeeplink: and tuneDidFailDeeplinkWithError: callbacks.
        
       //                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Tune.registerDeeplinkListener(self)
        
        // Uncomment this line to enable auto-measurement of successful in-app-purchase (IAP) transactions as "purchase" events
        //[Tune automateIapEventMeasurement:YES];
        
        
        // Check if a deferred deeplink is available and handle opening of the deeplink as appropriate in the success tuneDidReceiveDeeplink: callback.
        // Uncomment this line if your TUNE account has enabled deferred deeplinks
        //Tune.checkForDeferredDeeplink(self)
        
        // Uncomment this line to enable auto-measurement of successful in-app-purchase (IAP) transactions as "purchase" events
        //Tune.automateIapEventMeasurement(true)
        
        // Enable Smartwhere Proximity functionality
        //Tune.enableSmartwhereIntegration()
        // Enable Mapped Events
     //   Tune.configureSmartwhereIntegration(withOptions: Int(TuneSmartwhereShareEventData.rawValue))
       if let momId  : String = KeychainWrapper.standard.string(forKey: "uid"){
        if let doctor_id : String = KeychainWrapper.standard.string(forKey: "doctor_id"){
            

            
            
            
            Alamofire.request(functions.apiLink()+"apis/online.php", method: .post, parameters: [
                "mom_id": momId, "doctor_id": doctor_id], encoding: JSONEncoding.default)
                .responseJSON { response in
                    print(response)
            }
            
        }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
     
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        Tune.measureSession()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
  
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        if let momId  : String = KeychainWrapper.standard.string(forKey: "uid"){
        if let doctor_id : String = KeychainWrapper.standard.string(forKey: "doctor_id"){
            
            
            
            Alamofire.request(functions.apiLink()+"apis/online.php", method: .post, parameters: [
                "mom_id": momId, "doctor_id": doctor_id], encoding: JSONEncoding.default)
                .responseJSON { response in
                    print(response)
            }
            
        }
        
        }
        
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {

        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
    }

    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {

        // when the app is opened due to a deep link, call the Tune deep link setter
        //Tune.handleOpenURL(url, sourceApplication: sourceApplication)
        
        return true;
    }
    

    //MARK - UNNotification Delegate Methods
//
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert, .sound])
//    }
//
//
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//       let smartwhere = TuneSmartWhereHelper.getInstance().getSmartWhere() as! SmartWhere
//        if (!smartwhere.didReceive(response)) {
//            // Error
//        }
//        NSLog("User Info : %",response.notification.request.content.userInfo)
//        completionHandler()
//    }
//
//
//
//
//
//  }
//
//  extension AppDelegate:SmartWhereDelegate {
//    func smartWhere(_ smartwhere: SmartWhere, didReceiveLocalNotification notification: SWNotification) {
//        NSLog("SWNotification came in while in the foreground, alerting the user");
//        lastEvent = notification
//
//        let alertController = UIAlertController(title: notification.title, message: notification.message, preferredStyle: UIAlertControllerStyle.actionSheet)
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (result : UIAlertAction) -> Void in
//
//        }
//        let okAction = UIAlertAction(title: "Okay", style: .default) { (result : UIAlertAction) -> Void in
//
//        }
//
//        alertController.addAction(cancelAction)
//        alertController.addAction(okAction)
//
//        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
//
//
//    }
//
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //
        //        let momId = KeychainWrapper.standard.string(forKey: "uid")!
        //         if let saved_token : String = UserDefaults.standard.string(forKey: "token"){
        //
        //            Alamofire.request(functions.apiLink()+"apis/token.php", method: .post, parameters: [
        //                "uid": momId, "token": deviceToken])
        //                .validate(statusCode: 200..<300)
        //                .response { response in
        //                       print(response.request?.value)
        //
        //
        //                    }
        //
   // }
       //    print("|||||||||||aa|||||||||")
     //   dump(deviceToken);
     //   print("|||||||||||aa|||||||||")
      //  Tune.application(application, tuneDidRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
     //   Tune.application(application, tuneDidFailToRegisterForRemoteNotificationsWithError: error)
    }
    
    
 }
