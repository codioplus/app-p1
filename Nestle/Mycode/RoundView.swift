//
//  RoundView.swift
//  Nestle
//
//  Created by User on 2/27/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
@IBDesignable
class RoundView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
             self.layer.cornerRadius = cornerRadius
        }
    }
    
    

}
