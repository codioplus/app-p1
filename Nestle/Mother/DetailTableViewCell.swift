//
//  DetailTableViewCell.swift
//  Nestle
//
//  Created by User on 4/19/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import YouTubePlayer
class DetailTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var videoplayer: UIWebView!
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var kidName: UILabel!
    
    @IBOutlet weak var flagImage: UIButton!
    
    
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                dataImage.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                aspectConstraint?.priority = UILayoutPriority(rawValue: 999)  //add this
                dataImage.addConstraint(aspectConstraint!)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
    }
    
    func setPostedImage(image : UIImage) {
        
        let aspect = image.size.width / image.size.height
        
        aspectConstraint = NSLayoutConstraint(item: dataImage, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: dataImage, attribute: NSLayoutAttribute.height, multiplier: aspect, constant: 0.0)
        
        dataImage.image = image
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
