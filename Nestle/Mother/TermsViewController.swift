//
//  PopupViewController.swift
//  MIBlurPopup
//
//  Created by Mario on 14/01/2017.
//  Copyright © 2017 Mario. All rights reserved.
//

import UIKit

class TermsViewController : UIViewController {
    
    ///var titleVac: String?
    //var bodyVac: String?
    private var termPop = TermsPopupViewController()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? TermsPopupViewController,
            segue.identifier == "termPop" {
            self.termPop = vc
        }
    }
    var termUse = "privacy_notice"
    @IBOutlet weak var popupContentContainerView: UIView!
    @IBOutlet weak var popupMainView: UIView! {
        didSet {
            popupMainView.layer.cornerRadius = 15
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
   
            if let term = UserDefaults.standard.string(forKey: "termId") {
                
                if Functions().lang() == "ar"{
                
                if term == "1"{
                    self.termUse = "cookies_notice_ar"
                }else if term == "3"{
                    self.termUse = "terms_of_use_ar"
                }else{
                    self.termUse = "privacy_notice_ar"
                }
        
                }else{
                    
                    if term == "1"{
                        self.termUse = "cookies_notice"
                    }else if term == "3"{
                        self.termUse = "terms_of_use"
                    }else{
                        self.termUse = "privacy_notice"
                    }
                    
                }
            
            do {
                guard let filePath = Bundle.main.path(forResource: self.termUse, ofType: "htm")
                    else {
                        // File Error
                        print ("File reading error")
                        return
                }
                
                let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
                let baseUrl = URL(fileURLWithPath: filePath)
                self.termPop.webView.loadHTMLString(contents as String, baseURL: baseUrl)
            }
            catch {
                print ("File HTML error")
            }
                
            }
            UserDefaults.standard.set("", forKey: "termId")
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

// MARK: - MIBlurPopupDelegate

extension TermsViewController: MIBlurPopupDelegate {
    
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

