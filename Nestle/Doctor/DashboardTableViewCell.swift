//
//  DashboardTableViewCell.swift
//  Nestle
//
//  Created by User on 5/30/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var imageDashboard: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var nb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
