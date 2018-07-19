//
//  ShoutoutTableViewCell.swift
//  Nestle
//
//  Created by User on 6/4/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit

class ShoutoutTableViewCell: UITableViewCell {

    @IBOutlet weak var imageDoc: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var Desc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
