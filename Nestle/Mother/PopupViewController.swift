//
//  PopupViewController.swift
//  Nestle
//
//  Created by User on 3/29/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import JGProgressHUD

class PopupViewController: UIViewController{
      let functions = Functions()
      var momId = String()
      var token = String()
    
//@IBOutlet weak var dismissButton: UIButton! {
//        didSet {
//            dismissButton.layer.cornerRadius = dismissButton.frame.height/2
//        }
//    }
    let accounttype = KeychainWrapper.standard.string(forKey: "accounttype")!

var detail :Dataserver?
    
    
@IBOutlet weak var popupContentContainerView: UIView!
    
    private var ratingView = RatingPopupViewController()
    
@IBOutlet weak var popupMainView: UIView! {
        didSet {
            popupMainView.layer.cornerRadius = 15
        }
    }
    
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? RatingPopupViewController,
            segue.identifier == "ratingPop" {
            self.ratingView = vc
        }
    }
    
    

    
override func viewDidLoad() {
 
    
    
        super.viewDidLoad()
    
        self.ratingView.titleDetail.text = detail?.title

    
    if accounttype == "4"{
        
        self.ratingView.rateNow.isHidden = true
        self.ratingView.rating.settings.updateOnTouch = false
        
    }
    
    
    
         token  = KeychainWrapper.standard.string(forKey: "token")!
         momId  = KeychainWrapper.standard.string(forKey: "uid")!
        modalPresentationCapturesStatusBarAppearance = true
    if let count_rate = detail?.count_user_rate{
    if Int(count_rate)! > 0 {
       
      
        let np1:Float? = Float(detail!.p1) / Float(count_rate)!
        let np2:Float? = Float(detail!.p2) / Float(count_rate)!
        let np3:Float? = Float(detail!.p3) / Float(count_rate)!
        let np4:Float? = Float(detail!.p4) / Float(count_rate)!
        let np5:Float? = Float(detail!.p5) / Float(count_rate)!
        
        
        
        self.ratingView.progressbar5stars.progress = np5!
        self.ratingView.progressbar4stars.progress = np4!
        self.ratingView.progressbar3stars.progress = np3!
        self.ratingView.progressbar2stars.progress = np2!
        self.ratingView.progressbar1star.progress = np1!
        
        self.ratingView.percentStar1.text = String(format: "%.1f", (np1! * 100))+"%"
        self.ratingView.percentStar2.text = String(format: "%.1f", (np2! * 100))+"%"
        self.ratingView.percentStar3.text = String(format: "%.1f", (np3! * 100))+"%"
        self.ratingView.percentStar4.text = String(format: "%.1f", (np4! * 100))+"%"
        self.ratingView.percentStar5.text = String(format: "%.1f", (np5! * 100))+"%"
        
    
        self.ratingView.overallRatingUsers.text = " ("+(detail?.count_user_rate)!+") "
    


    
    self.ratingView.rating.rating = (detail?.rate_average)!
        
    }else{
 
        
        self.ratingView.overallRatingUsers.text = " (0) "
        
        self.ratingView.percentStar1.text = String(0)+"%"
        self.ratingView.percentStar2.text = String(0)+"%"
        self.ratingView.percentStar3.text = String(0)+"%"
        self.ratingView.percentStar4.text = String(0)+"%"
        self.ratingView.percentStar5.text = String(0)+"%"
        
        self.ratingView.progressbar5stars.progress = 0
        self.ratingView.progressbar4stars.progress = 0
        self.ratingView.progressbar3stars.progress = 0
        self.ratingView.progressbar2stars.progress = 0
        self.ratingView.progressbar1star.progress = 0
        
        self.ratingView.rating.rating = 0
        
        
        
        }
        
        if self.detail?.is_rate == "true"{
            self.ratingView.rateNow.setTitle(("alreadyRated").localiz(), for: .normal)
            self.ratingView.rateNow.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            self.ratingView.rateNow.isEnabled = false
            self.ratingView.rating.settings.updateOnTouch = false
            self.ratingView.rateNow.isUserInteractionEnabled = false
        }
    }
    
    
    self.ratingView.rateNow.addTarget(self, action: #selector(rateNowBtn), for: .touchUpInside)

    
    }
    
    
 
    
    @objc func rateNowBtn(_ sender: UIButton) {
        
        
        
        
        
        let hud = JGProgressHUD(style: .light)
        
        hud.textLabel.text = ("loading").localiz()
        
        hud.show(in: self.view)
        
        
        
        let parameters = ["uid":  momId, "nid": (self.detail?.nid!)!, "value": "\(self.ratingView.rating.rating)", "token": self.token] as [String : Any]
 
        
        let urlString = functions.apiLink()+"apis/rating.php"
        
        Alamofire.request(urlString, method: .post, parameters: parameters, headers: nil).responseString{
            response in
            switch response.result {
            case .success:
             //   print(response)
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                    UIView.animate(withDuration: 0.3) {
                        hud.indicatorView = nil
                        hud.textLabel.font = UIFont.systemFont(ofSize: 18.0)
                        
                        hud.textLabel.text = ("Done").localiz()
                        hud.position = .bottomCenter
                    }
                   hud.dismiss(afterDelay: 2.0)
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                    
                    self.detail?.is_rate = "true"
                        var count_r = Int((self.detail?.count_user_rate)!)
                        count_r = count_r! + 1
                        self.ratingView.overallRatingUsers.text = " (\(count_r ?? 0)+) "
                        
                        self.detail?.count_user_rate = "\(Int((self.detail?.count_user_rate)!)! + 1)"
                         var nnp1:Float?
                         var nnp2:Float?
                         var nnp3:Float?
                         var nnp4:Float?
                         var nnp5:Float?
                    
                    if self.ratingView.rating.rating == 1{
                         nnp1 = (Float(self.detail!.p1) + 1.0) / Float(count_r!)
                    }else{
                         nnp1 = Float(self.detail!.p1) / Float(count_r!)
                        
                    }
                    
                    
                    
                    if self.ratingView.rating.rating == 2{
                        nnp2 = (Float(self.detail!.p2) + 1.0) / Float(count_r!)
                    }else{
                        
                        nnp2 = Float(self.detail!.p2) / Float(count_r!)
                    }
                        
                        
                        
                    if self.ratingView.rating.rating == 3{
                        nnp3 = (Float(self.detail!.p3)  +  1.0) / Float(count_r!)
                    }else{
                        nnp3 = Float(self.detail!.p3) / Float(count_r!)
                        
                    }
                    
                    
                    
                    
                    if self.ratingView.rating.rating == 4{
                        nnp4 = (Float(self.detail!.p4) + 1.0) / Float(count_r!)
                    }else{
                        
                        nnp4 = Float(self.detail!.p4) / Float(count_r!)
                    }
                    
                      if self.ratingView.rating.rating == 5{
                        nnp5 = (Float(self.detail!.p5)  + 1.0) / Float(count_r!)
                      }else{
                        nnp5 = Float(self.detail!.p5) / Float(count_r!)
                        
                    }
                    
                    
                    self.ratingView.progressbar5stars.progress = nnp5!
                    self.ratingView.progressbar4stars.progress = nnp4!
                    self.ratingView.progressbar3stars.progress = nnp3!
                    self.ratingView.progressbar2stars.progress = nnp2!
                    self.ratingView.progressbar1star.progress = nnp1!
                    
                    self.ratingView.percentStar1.text = String(format: "%.1f", (nnp1! * 100))+"%"
                    self.ratingView.percentStar2.text = String(format: "%.1f", (nnp2! * 100))+"%"
                    self.ratingView.percentStar3.text = String(format: "%.1f", (nnp3! * 100))+"%"
                    self.ratingView.percentStar4.text = String(format: "%.1f", (nnp4! * 100))+"%"
                    self.ratingView.percentStar5.text = String(format: "%.1f", (nnp5! * 100))+"%"
                    
                    }
                    
                    sender.setTitle(("alreadyRated").localiz(), for: .normal)
                    sender.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                    self.ratingView.rateNow.isUserInteractionEnabled = false
                    self.ratingView.rateNow.isEnabled = false
                    self.ratingView.rating.settings.updateOnTouch = false
                }
                break
            case .failure(let error):
                
                print(error)
            }
        }
        
   
        
        
    }
    
    
    
    
@IBAction func dismissButtonTapped(_ sender: Any) {
       dismiss(animated: true)
    }
}


extension PopupViewController: MIBlurPopupDelegate {

        var popupView: UIView {
            return popupContentContainerView ?? UIView()
        }
    
    

    
    var blurEffectStyle: UIBlurEffectStyle {
        
        return .dark
    }
    
    var initialScaleAmmount: CGFloat {
        return 0.7
    }
    
    var animationDuration: TimeInterval {
        return 0.5
    }
  
    
    
    
}





