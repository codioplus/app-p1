//
//  GrowthTableViewCell.swift
//  Nestle
//
//  Created by User on 7/16/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import WheelPicker



class GrowthTableViewCell: UITableViewCell, UINavigationControllerDelegate{


    @IBOutlet weak var picker1: WheelPicker!
    
    @IBOutlet weak var picker2: WheelPicker!
    
    let functions = Functions()
    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var girl: RoundBtn!
    @IBOutlet weak var boy: RoundBtn!
    
    @IBOutlet weak var weight: UILabel!
    var pickerView = UIPickerView()

    @IBOutlet weak var monthsBtn: UIButton!
    
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var check_now: RoundBtn!
    
    fileprivate var months = ["November", "December", "January", "Febrary", "March", "April", "May", "June", "July", "August", "September", "October"]
    fileprivate var years = ["2011", "2012", "2013", "2014", "2015", "2016", "2017"]

    
    
    var selectedBoy : Bool = true
    var selectedGirl : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        picker1.dataSource = self
        picker2.delegate = self
        
        picker2.interitemSpacing = 25.0
        picker2.style = .styleFlat
        picker2.isMaskDisabled = true
        picker2.scrollDirection = .horizontal
        
        picker2.textColor = UIColor.white.withAlphaComponent(0.5)
        picker2.highlightedTextColor = UIColor.white
        
        
        picker1.dataSource = self
        picker1.delegate = self
        
        picker1.interitemSpacing = 25.0
        picker1.style = .styleFlat
        picker1.isMaskDisabled = true
        picker1.scrollDirection = .horizontal
        picker1.textColor = UIColor.white.withAlphaComponent(0.5)
        picker1.highlightedTextColor = UIColor.white

        
        self.girl.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        self.girl.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1) , for: .normal)
        self.boy.layer.borderColor = #colorLiteral(red: 0.3647058824, green: 0.7098039216, blue: 0.6431372549, alpha: 1)
        self.boy.setTitleColor(#colorLiteral(red: 0.3647058824, green: 0.7098039216, blue: 0.6431372549, alpha: 1) , for: .normal)
        self.weight.text = ("cweight").localiz()
        self.height.text = ("cheight").localiz()
        self.gender.text = ("cgender").localiz()
        self.age.text = ("cage").localiz()
        
        self.girl.setTitle(("girl").localiz(), for: .normal)
        self.boy.setTitle(("boy").localiz(), for: .normal)
        self.check_now.setTitle(("check_now").localiz(), for: .normal)
        self.monthsBtn.setTitle(("monthsBtn").localiz(), for: .normal)
        
       // actualLabel1.text = String(format: "%.02f", slider1.value)
       
       // actualLabel2.text = String(format: "%.02f", slider2.value)
    
        
    }
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    



    @IBAction func ageBtn(_ sender: UIButton) {

        
        ActionSheetStringPicker.show(withTitle: "", rows: ["0 "+("monthTxt").localiz(),
                                                           "1 "+("monthTxt").localiz(),
                                                           "2 "+("monthsTxt").localiz(),
            "3 "+("monthsTxt").localiz(),
            "4 "+("monthsTxt").localiz(),
            "5 "+("monthsTxt").localiz(),
            "6 "+("monthsTxt").localiz(),
            "7 "+("monthsTxt").localiz(),
            "8 "+("monthsTxt").localiz(),
            "9 "+("monthsTxt").localiz(),
            "10 "+("monthsTxt").localiz(),
            "11 "+("monthsTxt").localiz(),
            "12 "+("monthsTxt").localiz(),
            "13 "+("monthsTxt").localiz(),
            "14 "+("monthsTxt").localiz(),
            "15 "+("monthsTxt").localiz(),
            "16 "+("monthsTxt").localiz(),
            "17 "+("monthsTxt").localiz(),
            "18 "+("monthsTxt").localiz(),
            "19 "+("monthsTxt").localiz(),
            "20 "+("monthsTxt").localiz(),
            "21 "+("monthsTxt").localiz(),
            "22 "+("monthsTxt").localiz(),
            "23 "+("monthsTxt").localiz(),
            "24 "+("monthsTxt").localiz(),
            "25 "+("monthsTxt").localiz(),
            "26 "+("monthsTxt").localiz(),
            "27 "+("monthsTxt").localiz(),
            "28 "+("monthsTxt").localiz(),
            "29 "+("monthsTxt").localiz(),
            "30 "+("monthsTxt").localiz(),
            "31 "+("monthsTxt").localiz(),
            "32 "+("monthsTxt").localiz(),
            "33 "+("monthsTxt").localiz(),
            "34 "+("monthsTxt").localiz(),
            "35 "+("monthsTxt").localiz(),
            "36 "+("monthsTxt").localiz()
            ], initialSelection: 0, doneBlock: {
            picker, value, index in
                self.monthsBtn.setTitle("\(index!)" , for: .normal)
     
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
        
  
    }
    @IBAction func girlBtn(_ sender: UIButton) {
        
         if(self.selectedGirl == false){
            
            self.girl.layer.borderColor = #colorLiteral(red: 0.9607843137, green: 0.4784313725, blue: 0.5098039216, alpha: 1)
            self.girl.setTitleColor(#colorLiteral(red: 0.9607843137, green: 0.4784313725, blue: 0.5098039216, alpha: 1) , for: .normal)
            
            self.boy.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
                  self.boy.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1) , for: .normal)
            self.selectedGirl = true
            self.selectedBoy = false
        }
    }
    
    
    @IBAction func boyBtn(_ sender: Any) {
        
        if(self.selectedBoy == false){
            
            self.girl.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
            self.girl.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1) , for: .normal)
            self.boy.layer.borderColor = #colorLiteral(red: 0.3647058824, green: 0.7098039216, blue: 0.6431372549, alpha: 1)
            self.boy.setTitleColor(#colorLiteral(red: 0.3647058824, green: 0.7098039216, blue: 0.6431372549, alpha: 1) , for: .normal)
  
       self.selectedGirl = false
       self.selectedBoy = true
        }
        
        
    }

    



    
}




extension GrowthTableViewCell: WheelPickerDataSource {
    
    func numberOfItems(_ wheelPicker: WheelPicker) -> Int {
        
        if picker2 == wheelPicker {
            return months.count
        } else if picker1 == wheelPicker {
            return years.count
        }
        return 0
    }
    
    func titleFor(_ wheelPicker: WheelPicker, at index: Int) -> String {
        
        if picker2 == wheelPicker {
            return months[index]
        } else if picker1 == wheelPicker {
            return years[index]
        }
        return ""
    }
}

extension GrowthTableViewCell:WheelPickerDelegate {
    
    func wheelPicker(_ wheelPicker: WheelPicker, didSelectItemAt index: Int) {
        
        if picker2 == wheelPicker {
            print("\(months[index])")
        } else if picker1 == wheelPicker {
            print("\(years[index])")
        }
        
    }
    
    func wheelPicker(_ wheelPicker: WheelPicker, marginForItem index: Int) -> CGSize {
        
        return CGSize(width: 0.0 , height: 0.0)
    }
    
    //        func wheelPicker(_ wheelPicker: WheelPicker, configureLabel label: UILabel, for index: Int) {
    //
    //            label.textColor = UIColor.black.withAlphaComponent(0.5)
    //            label.highlightedTextColor = UIColor.black
    //            label.backgroundColor = UIColor.init(hue: CGFloat(index)/CGFloat(flags.count) , saturation: 1.0, brightness: 1.0, alpha: 1.0)
    //        }
}
