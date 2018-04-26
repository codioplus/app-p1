//
//  HomeTableViewController.swift
//  Nestle
//
//  Created by User on 3/2/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import SideMenu
class HomeTableViewController: UITableViewController {

    let functions = Functions()
    
    
    @IBOutlet weak var milestoneMainLabel: UILabel!
    @IBOutlet weak var milestoneDescLabel: UILabel!
    @IBOutlet weak var tipsFor1: UILabel!
    @IBOutlet weak var tipsFor2: UILabel!
    @IBOutlet weak var parentTips: UILabel!
    @IBOutlet weak var feedingTips: UILabel!
    @IBOutlet weak var BrainMainLabel: UILabel!
    @IBOutlet weak var BrainDescLabel: UILabel!
    @IBOutlet weak var vaccinationMainLabel: UILabel!
    @IBOutlet weak var vaccinationDescLabel: UILabel!
    @IBOutlet weak var growthMainLabel: UILabel!
    @IBOutlet weak var videosMainLabel: UILabel!
 
override func viewDidLoad() {
    
super.viewDidLoad()
functions.menuRight(controller: self)
self.title = NSLocalizedString("home", comment: "Home")

milestoneMainLabel.text = NSLocalizedString("milestoneMainLabel", comment: "Milestone")
milestoneDescLabel.text = NSLocalizedString("milestoneDescLabel", comment: "Description")

vaccinationMainLabel.text = NSLocalizedString("vaccinationMainLabel", comment: "Vaccination")
vaccinationDescLabel.text = NSLocalizedString("vaccinationDescLabel", comment: "Description")

BrainMainLabel.text = NSLocalizedString("BrainMainLabel", comment: "Brain Activities")
BrainDescLabel.text = NSLocalizedString("BrainDescLabel", comment: "Description")
growthMainLabel.text = NSLocalizedString("growthMainLabel", comment: "Growth Chart")
videosMainLabel.text = NSLocalizedString("videosMainLabel", comment: "Videos")

tipsFor1.text = NSLocalizedString("tipsFor1", comment: "Tips For")
tipsFor2.text = NSLocalizedString("tipsFor2", comment: "Tips For")
parentTips.text = NSLocalizedString("parentTips", comment: "Parenting")
feedingTips.text = NSLocalizedString("feedingTips", comment: "Feeding")

        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//print(indexPath[1])
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = Storyboard.instantiateViewController(withIdentifier: "MotherMilestoneUIViewController") as! MotherMilestoneUIViewController
        Dvc.type = "milestone"
        Dvc.type_id = 1
        self.navigationController?.pushViewController(Dvc, animated: true)
        
        
    }
    
    @IBAction func openRightMenu(_ sender: UIBarButtonItem) {
        
        present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        
    }

    
    
    
}
