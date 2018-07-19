//
//  ChartTableViewCell.swift
//  Nestle
//
//  Created by User on 7/16/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import UIKit
import Charts
class ChartTableViewCell: UITableViewCell , ChartViewDelegate{
 @IBOutlet weak var lineChartView: LineChartView!
      let functions = Functions()
    
    override func awakeFromNib() {
        super.awakeFromNib()
       lineChartView.dragEnabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.setScaleEnabled(false)
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = false
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func setYAxisDesign(){
        
        
       // let leftYAxis = lineChartView.getAxis(YAxis.AxisDependency.left)
       // leftYAxis.drawLabelsEnabled = false
       // leftYAxis.enabled = false
        
        // add reference line
        
        let line = ChartLimitLine(limit:60)
      
        
        let rightYAxis = lineChartView.getAxis(YAxis.AxisDependency.right)
        rightYAxis.drawGridLinesEnabled = false
        rightYAxis.enabled = false
        
        
        
        rightYAxis.drawAxisLineEnabled = false
        
        
        rightYAxis.addLimitLine(line)
        
    }
    
    
    func setXAxisDesign(){
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        
    }
    func setChartDesign(){
        
        lineChartView.drawGridBackgroundEnabled = false
       // lineChartView.animate(xAxisDuration: 1.0, easingOption: .easeInOutCubic)
        
        lineChartView.noDataText = "no data information, add data points!"
    }
    func setChart(dataPoints: [Chart], gender: Int,age: Double, selectedWeight: Double, selectedHeight: Double, selectType: Int){
        var clr:String
        if gender == 0{
            
           clr = "#5DB5A4";
            
        }else{
            
            clr = "#F57A82";
            
        }
      
        
        lineChartView.delegate = self
        
        var dataEntries1: [ChartDataEntry] = []
        var dataEntries2: [ChartDataEntry] = []
        var dataEntries3: [ChartDataEntry] = []
        var dataEntries4: [ChartDataEntry] = []
        var dataEntries5: [ChartDataEntry] = []
        let data = LineChartData()
        
      
        
        
        for i in 0..<dataPoints.count{
          
            if let ydata = dataPoints[i].p3{
                
                let DataEntry1 = ChartDataEntry(x: Double(i), y: Double(ydata)!)
                dataEntries1.append(DataEntry1)

            }
            
        }
            
            let line1 = LineChartDataSet(values: dataEntries1, label: nil)
        line1.colors = [functions.hexStringToUIColor(hex: clr)]
        line1.lineWidth = 3
        line1.drawCircleHoleEnabled = false
        line1.drawCirclesEnabled = false
            data.addDataSet(line1)
            
     
        
        

        
        
            
            for i in 0..<dataPoints.count{
                
                if let ydata = dataPoints[i].p15{
                    
                    let DataEntry2 = ChartDataEntry(x: Double(i), y: Double(ydata)!)
                    dataEntries2.append(DataEntry2)
                    
                }
                
            }
            
            let line2 = LineChartDataSet(values: dataEntries2, label: nil)
        line2.colors = [functions.hexStringToUIColor(hex: clr)]
        line2.lineWidth = 3
        line2.drawCircleHoleEnabled = false
        line2.drawCirclesEnabled = false
            data.addDataSet(line2)
            
     
        
        
        
   
            
            for i in 0..<dataPoints.count{
                
                if let ydata = dataPoints[i].p50{
                    
                    let DataEntry3 = ChartDataEntry(x: Double(i), y: Double(ydata)!)
                    dataEntries3.append(DataEntry3)
                    
                }
                
            }
            
            let line3 = LineChartDataSet(values: dataEntries3, label: nil)
        
        line3.drawCircleHoleEnabled = false
        line3.drawCirclesEnabled = false
        line3.colors = [functions.hexStringToUIColor(hex: clr)]
        line3.lineWidth = 3
            data.addDataSet(line3)
            
   
        
        
   
            
            for i in 0..<dataPoints.count{
                
                if let ydata = dataPoints[i].p85{
                    
                    let DataEntry4 = ChartDataEntry(x: Double(i), y: Double(ydata)!)
                    dataEntries4.append(DataEntry4)
                    
                }
                
            }
            
            let line4 = LineChartDataSet(values: dataEntries4, label: nil)
        line4.colors = [functions.hexStringToUIColor(hex: clr)]
        line4.lineWidth = 3
        line4.drawCircleHoleEnabled = false
        line4.drawCirclesEnabled = false
            data.addDataSet(line4)
            

        
      
            
            for i in 0..<dataPoints.count{
                
                if let ydata = dataPoints[i].p97{
                    
                    let DataEntry5 = ChartDataEntry(x: Double(i), y: Double(ydata)!)
                    dataEntries5.append(DataEntry5)
                    
                }
                
            }
            
            let line5 = LineChartDataSet(values: dataEntries5, label: nil)
        line5.drawCircleHoleEnabled = false
         line5.drawCirclesEnabled = false
        line5.colors = [functions.hexStringToUIColor(hex: clr)]
        line5.lineWidth = 3
            data.addDataSet(line5)
            
  
        

        lineChartView.data = data
        
        lineChartView.chartDescription?.text = ""
        
//        for i in 0..<values.count{
//            let DataEntry = ChartDataEntry(x: values[i],y:Double(i))
//
//            dataEntries.append(DataEntry)
//
//            dataDays.append(dataPoints[count])
//            if (count == dataPoints.count - 1){
//                count = 0
//            }else{
//                count = count + 1
//            }
//        }
//
//        let lineChartDataSet = LineChartDataSet(values: dataEntries, label:nil)
//
//        lineChartDataSet.lineWidth = 2.0
//        lineChartDataSet.colors = [NSUIColor.blue]
//        lineChartDataSet.circleColors = [NSUIColor.red]
//
//        data.addDataSet(lineChartDataSet)
//        lineChartView.data = data
        
        
    }
    
    
    ///ChartView delegate
    
    func chartScaled(chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat){
        print(scaleX)
        print(scaleY)
    }
    
    func chartTranslated(chartView: ChartViewBase, dX: CGFloat, dY: CGFloat){
        print(dX)
        print(dY)
    }
    
    
}
