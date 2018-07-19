//
//  RegistedTableViewCell.swift
//  Nestle
//
//  Created by User on 5/30/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit

class RegistedTableViewCell: UITableViewCell {

    @IBOutlet weak var clCollectionView: UICollectionView!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var motherImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var children: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
//        
//        let mScreenSize = UIScreen.main.bounds
//        let mSeparatorHeight = CGFloat(15.0) // Change height of speatator as you want
//        let mAddSeparator = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height - mSeparatorHeight, width: mScreenSize.width, height: mSeparatorHeight))
//        mAddSeparator.backgroundColor = #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
//        self.addSubview(mAddSeparator)
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.children.text = ("children").localiz()
        clCollectionView.isScrollEnabled = false

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



extension RegistedTableViewCell
{
    
    func setCollectionViewDataSourceDelegate
        
        <D: UICollectionViewDelegate & UICollectionViewDataSource>
        (_ dataSourceDelegate: D, forRow row:Int)
    
    {
    
        clCollectionView.delegate = dataSourceDelegate
        clCollectionView.dataSource = dataSourceDelegate
        clCollectionView.tag = row
        clCollectionView.setContentOffset(clCollectionView.contentOffset, animated: false)
        clCollectionView.reloadData()
        
    }
    
    var collectionViewOffset: CGFloat {
        set{ clCollectionView.contentOffset.x = newValue}
        get {return clCollectionView.contentOffset.x}
    }
    
}
