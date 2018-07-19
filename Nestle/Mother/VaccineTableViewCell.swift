//
//  VaccineTableViewCell.swift
//  Nestle
//
//  Created by User on 5/10/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit

class VaccineTableViewCell: UITableViewCell {

    @IBOutlet weak var currentImage: UIButton!
    @IBOutlet weak var tapText: UIButton!
    @IBOutlet weak var titleVaccine: UILabel!
    @IBOutlet weak var roundView: RoundView!
    @IBOutlet weak var completeText: UILabel!
    @IBOutlet weak var hospital: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var lockView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
