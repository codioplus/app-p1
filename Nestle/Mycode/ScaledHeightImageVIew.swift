//
//  ScaledHeightImageVIew.swift
//  Nestle
//
//  Created by User on 4/19/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import Foundation
import UIKit
class ScaledHeightImageView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = UIScreen.main.bounds.width //self.frame.size.width
            
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            
            return CGSize(width: myViewWidth, height: scaledHeight)
        }
        
        return CGSize(width: -1.0, height: -1.0)
    }
    
}
