//
//  DetailTableViewCell.swift
//  Nestle
//
//  Created by User on 4/19/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var kidName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
