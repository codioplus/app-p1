//
//  PopupViewController.swift
//  Nestle
//
//  Created by User on 3/29/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit


class PopupViewController: UIViewController{
//@IBOutlet weak var dismissButton: UIButton! {
//        didSet {
//            dismissButton.layer.cornerRadius = dismissButton.frame.height/2
//        }
//    }
    
@IBOutlet weak var popupContentContainerView: UIView!
    
    
@IBOutlet weak var popupMainView: UIView! {
        didSet {
            popupMainView.layer.cornerRadius = 20
        }
    }
    
override func viewDidLoad() {

        
        super.viewDidLoad()
        
        modalPresentationCapturesStatusBarAppearance = true
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





