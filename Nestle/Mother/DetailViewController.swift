//
//  DetailViewController.swift
//  Nestle
//
//  Created by User on 4/17/18.
//  Copyright © 2018 Nestle. All rights reserved.
//



import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func favouriate(_ sender: UIButton) {
       if sender.currentImage == UIImage(named:"ic_heart_off.png"){
            sender.setImage(UIImage(named:"ic_heart_on.png"), for: .normal)
        }else{
            sender.setImage(UIImage(named:"ic_heart_off.png"), for: .normal)
        }

    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        if indexPath[1] == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "detail0", for: indexPath) as! DetailTableViewCell
            
            cell.kidName.text = "Ahmad - 12 months"
                return cell
        }
        
        
        else {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as! DetailTableViewCell
        
        cell.dataImage.image = UIImage(named: "milestone1.png")
           return cell
        }
    
    }
    
     var img : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
}
}
