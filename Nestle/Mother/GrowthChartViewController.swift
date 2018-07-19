//
//  GrowthChartViewController.swift
//  Nestle
//
//  Created by User on 7/16/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import JGProgressHUD
import Charts
import SideMenu
import ActionSheetPicker_3_0


class GrowthChartViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, ChartViewDelegate, UINavigationControllerDelegate{
    
    
    @IBOutlet weak var monthsBtn: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    let functions = Functions()
    
    var selectedBoy : Bool = true
    var selectedGirl : Bool = false
    var selectedAge : Double = 0
    var selectedHeight : Double = 0
    var selectedWeight: Double = 0
    
    var selectType : Int = 0
    
    
    let accounttype = KeychainWrapper.standard.string(forKey: "accounttype")!
    
    
    @IBAction func boy(_ sender: UIButton) {
         if(self.selectedBoy == false){
        self.selectedGirl = false
        self.selectedBoy = true
        let  _ = APIManager.shared.fetchChartApi(country: "1", gender: "0" , type: "1")
            .done{
                chart  in
                
                self.model = chart
                
                self.tableView.reloadData()
            }.catch{ error
                -> Void in
                print ("error")
            }
        }
    }
    
    @IBAction func girl(_ sender: UIButton) {
        if(self.selectedGirl == false){
        self.selectedGirl = true
        self.selectedBoy = false
        
        let  _ = APIManager.shared.fetchChartApi(country: "1", gender: "1" , type: "1")
            .done{
                chart  in
                
                self.model = chart
                
                self.tableView.reloadData()
            }.catch{ error
                -> Void in
                print ("error")
                
        }
        }
        
    }
    
    
    
    
    var model = [Chart]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath[1] == 0{
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ChartTableViewCell
            if self.selectedGirl == false{
                
                cell.setChart(dataPoints: self.model, gender: 0, age: selectedAge, selectedWeight: selectedWeight, selectedHeight: selectedHeight, selectType: selectType)
                
            }else{
                
           cell.setChart(dataPoints: self.model, gender: 1, age: selectedAge, selectedWeight: selectedWeight, selectedHeight: selectedHeight, selectType: selectType)
            }
        cell.setChartDesign()
        cell.setXAxisDesign()
        cell.setYAxisDesign()
            
        return cell
            
       }
        else{
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! GrowthTableViewCell
               return cell
        }
     
    }

    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if indexPath[1] == 0{
        return 380
               }else{
          return 500
        }
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = ("Growth_Chart").localiz()
        
        if accounttype == "4"{
            designFooter()
        }
        

        
        
        let  _ = APIManager.shared.fetchChartApi(country: "1", gender: "0" , type: "1")
            .done{
                chart  in
                
                self.model = chart
              
                self.tableView.reloadData()
            }.catch{ error
                -> Void in
          print ("error")
                
        }
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    @IBAction func openRightMenu(_ sender: UIBarButtonItem) {
        
        if functions.lang() == "ar"{
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        }else{
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        }
        
    }
    
    func designFooter() {
        
        let viewFooter: UIView! = UIView(frame: CGRect(x:0, y: self.view.bounds.size.height - 33, width: self.view.bounds.size.width, height: 33))
        
        viewFooter.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.8862745098, blue: 0.6235294118, alpha: 1)
        self.view!.addSubview(viewFooter)
        
        let noDataLabel : UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: viewFooter.bounds.size.width, height: 33))
        noDataLabel.text = ("prof_use").localiz()
        
        noDataLabel.textAlignment = .center
        noDataLabel.font = UIFont(name: "Gotham-Book", size: 14)
        
        viewFooter.addSubview(noDataLabel)
    }
    
    
    

    
}
