//
//  RatingPopupViewController.swift
//  Nestle
//
//  Created by User on 4/20/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class RatingPopupViewController: UIViewController {

     let functions = Functions()
    @IBOutlet var stars: UIView!
    @IBOutlet weak var rateNow: UIButton!
    @IBOutlet weak var overallRatingUsers: UILabel!
    @IBOutlet weak var othersRating: UILabel!
    @IBOutlet weak var rating: CosmosView!
    
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var progressbar1star: UIProgressView!
    @IBOutlet weak var progressbar2stars: UIProgressView!
    @IBOutlet weak var progressbar3stars: UIProgressView!
    @IBOutlet weak var progressbar4stars: UIProgressView!
    @IBOutlet weak var progressbar5stars: UIProgressView!
    
    @IBOutlet weak var stars5: UILabel!
    @IBOutlet weak var stars4: UILabel!
    @IBOutlet weak var stars3: UILabel!
    @IBOutlet weak var stars2: UILabel!
    @IBOutlet weak var stars1: UILabel!
    @IBOutlet weak var percentStar5: UILabel!
    
    @IBOutlet weak var percentStar4: UILabel!
    
    @IBOutlet weak var percentStar3: UILabel!
    
    @IBOutlet weak var percentStar2: UILabel!
    
    @IBOutlet weak var percentStar1: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   let momId : String = KeychainWrapper.standard.string(forKey: "uid")!
      self.othersRating.text = ("numberOfRates").localiz()
      self.titleDetail.text = ("numberOfRates").localiz()
      self.rateNow.setTitle(("rate_now").localiz(), for: .normal)
      self.progressbar1star.progress = 0
      self.progressbar2stars.progress = 0
      self.progressbar3stars.progress = 0
      self.progressbar4stars.progress = 0
      self.progressbar5stars.progress = 0
        
      self.rating.rating = 0
        
       self.stars5.text = ("stars5").localiz()
       self.stars4.text = ("stars4").localiz()
       self.stars3.text = ("stars3").localiz()
       self.stars2.text = ("stars2").localiz()
       self.stars1.text = ("stars1").localiz()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
}
