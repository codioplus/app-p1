//
//  DataCollectionViewCell.swift
//  
//
//  Created by User on 4/13/18.
//

import UIKit
import Cosmos
class DataCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lockView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var favourite: UIImageView!
    @IBOutlet weak var viewCon: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.viewCon.layer.cornerRadius = 15
        self.viewCon.layer.shadowColor = UIColor.black.cgColor
        self.viewCon.layer.shadowRadius = 5
        self.viewCon.layer.shadowOpacity = 0.2
        self.viewCon.layer.masksToBounds = false
        self.viewCon.clipsToBounds = false
        self.viewCon.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.myImage.layer.masksToBounds = true
        self.lockView.layer.masksToBounds = true
           self.myImage.clipsToBounds = true
        self.myImage.layer.cornerRadius = 15
        self.myImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        //self.myImage.translatesAutoresizingMaskIntoConstraints = tr
       // self.myImage.roundCorners([.topLeft, .topRight], 15, self)
       // self.myImage.frame = CGRect(x: 0, y: 0, width: self.viewCon.frame.size.width, height: 100)
       self.lockView.layer.cornerRadius = 15
      //  self.myImage.frame = CGRect(x: 0, y: 0, width: self.viewCon.frame.size.width, height: self.viewCon.frame.size.height)
        self.layer.masksToBounds = false
        self.clipsToBounds = false
    }
    

    
    
    
    
}

extension UIView {
    func roundCorners(_ corner: UIRectCorner,_ radii: CGFloat,_ cell: UICollectionViewCell) {
        let maskLayer = CAShapeLayer()
      //  maskLayer.frame = self.layer.frame
       maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: 100), byRoundingCorners: corner, cornerRadii: CGSize(width: radii, height: radii)).cgPath
        
        self.layer.mask = maskLayer
        layer.masksToBounds = true
    }
}
