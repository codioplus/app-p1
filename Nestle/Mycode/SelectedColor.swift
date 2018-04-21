//
//  SelectedColor.swift
//  Nestle
//
//  Created by User on 4/10/18.
//  Copyright © 2018 Nestle. All rights reserved.
//
import UIKit
@IBDesignable
class SelectableTableViewCell: UITableViewCell {
    
    @IBInspectable var selectionColor: UIColor = .gray {
        didSet {
            configureSelectedBackgroundView()
        }
    }
    
    func configureSelectedBackgroundView() {
        let view = UIView()
        view.backgroundColor = selectionColor
        selectedBackgroundView = view
    }
    
}
