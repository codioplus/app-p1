//
//  MotherMilestoneUIViewController.swift
//  Nestle
//
//  Created by User on 4/10/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit

class MotherMilestoneUIViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet weak var collectionView: UICollectionView!
    let array:[String] = ["profile_image","2","3"]
    var type = String()
    var type_id = Int()
    
   
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        self.title = NSLocalizedString("milestone", comment: "Milestone")
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
        layout.minimumInteritemSpacing = 20
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 50)/2, height: 265)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return array.count
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DataCollectionViewCell
        
        cell.myImage.image = UIImage(named: array[indexPath.row] + ".png")
        if indexPath.row == 1{
        cell.lockView.isHidden = false
        }
        cell.layer.cornerRadius = 10
    
        cell.layer.shadowColor = UIColor.darkGray.cgColor
     
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOpacity = 0.6
        cell.favourite.image = UIImage(named: "ic_heart_on.png")

        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //  let selectedIndex = indexPath.row
        if indexPath.row == 1{
            return
        }else{
            performSegue(withIdentifier: "showDetails", sender: self)
            
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.img = "2.png"
        }
    }
}
