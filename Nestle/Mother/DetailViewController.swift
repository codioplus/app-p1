//
//  DetailViewController.swift
//  Nestle
//
//  Created by User on 4/17/18.
//  Copyright © 2018 Nestle. All rights reserved.
//



import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import SideMenu
import JGProgressHUD
import YouTubePlayer
//import Kingfisher
class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var detail :Dataserver?
    var nid = String()
    var type = String()
    var type_id = Int()
    var child_age = String()
    var child_id = String()
    var child_name = String()
    let functions = Functions()
    var momId = String()
    
    @IBOutlet weak var rating: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    let accounttype = KeychainWrapper.standard.string(forKey: "accounttype")!
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rating" {
 
            if let destination = segue.destination as? PopupViewController {
                
                destination.detail = self.detail
                
            }
            
            
        }
    }
    
    
    
    @IBAction func openRightMenu(_ sender: UIBarButtonItem) {
        
        if functions.lang() == "ar"{
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        }else{
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func favouriate(_ sender: UIButton) {
        
        let hud = JGProgressHUD(style: .light)
       
        hud.textLabel.text = ("loading").localiz()
     
        hud.show(in: self.view)
        
       if sender.currentImage == UIImage(named:"ic_heart_off.png"){
        print(nid+" "+momId)
        
        Alamofire.request(functions.apiLink()+"apis/flags.php", method: .post, parameters: [
            "uid": momId, "nid": nid, "type": "1"])
            .validate(statusCode: 200..<300)
            .response { response in
            //    print(response.request?.value)
                self.detail?.isFlagged = "true"
                sender.setImage(UIImage(named:"ic_heart_on.png"), for: .normal)
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                    UIView.animate(withDuration: 0.3) {
                        hud.indicatorView = nil
                        hud.textLabel.font = UIFont.systemFont(ofSize: 18.0)
                        
                        hud.textLabel.text = ("addedtoFav").localiz()
                        hud.position = .bottomCenter
                    }
                }
                
                hud.dismiss(afterDelay: 2.0)
        }
        
        

        
        
        
        
        
        }else{
        
        
        Alamofire.request(functions.apiLink()+"apis/flags.php",method: .post, parameters: [
            "uid": momId, "nid": nid, "type": "0"])
            .validate(statusCode: 200..<300)
           
            .response { response in
             //   print(response.request?.value)
                self.detail?.isFlagged = "false"
                   sender.setImage(UIImage(named:"ic_heart_off.png"), for: .normal)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                    UIView.animate(withDuration: 0.3) {
                        hud.indicatorView = nil
                        hud.textLabel.font = UIFont.systemFont(ofSize: 18.0)
                        hud.textLabel.text = ("removedFav").localiz()
                        hud.position = .bottomCenter
                    }
                }
                
                hud.dismiss(afterDelay: 2.0)
        }
        
        
        }

    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     //   print(indexPath.row)
        if indexPath[1] == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "detail0", for: indexPath) as! DetailTableViewCell
        //    print(detail?.isFlagged)
            if let isFlagged = detail?.isFlagged{
                
                do {
                    
                    if isFlagged.elementsEqual("true") == true {
                        
                        cell.flagImage.setImage(UIImage(named:"ic_heart_on.png"), for: .normal)
                    }else{
                        cell.flagImage.setImage(UIImage(named:"ic_heart_off.png"), for: .normal)
                    }
                }
            }
            cell.kidName.text = detail?.title
                return cell
        }
            
            
        else {

            if self.type == "favourite"{
                if self.detail?.youtube_id != ""{
                           let cell = tableView.dequeueReusableCell(withIdentifier: "videoDetail", for: indexPath) as! DetailTableViewCell
                 if let youtube = self.detail?.youtube_id{

               
                    cell.videoplayer.loadRequest(URLRequest(url: URL(string: "https://www.youtube.com/embed/"+youtube)!))
    // print("a3")
               
                 }
                    
                     return cell
                }
                 
                 else {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as! DetailTableViewCell
                    
                    let url = URL(string: (self.detail?.image)!)
                    let data = try? Data(contentsOf: url!)
                    let img = UIImage(data: data!)
                    cell.dataImage.contentMode = UIViewContentMode.scaleAspectFit
                    cell.setPostedImage(image: img!)
                    
                    
                    return cell
                }
                
            }
            else{
            
            if self.type == "video"{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "videoDetail", for: indexPath) as! DetailTableViewCell
                if let youtube = self.detail?.youtube_id{
          cell.videoplayer.loadRequest(URLRequest(url: URL(string: "https://www.youtube.com/embed/"+youtube)!))
                   
            }
             return cell
            }
        
        else {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as! DetailTableViewCell
        
            let url = URL(string: (self.detail?.image)!)
            let data = try? Data(contentsOf: url!)
            let img = UIImage(data: data!)
            cell.dataImage.contentMode = UIViewContentMode.scaleAspectFit
            cell.setPostedImage(image: img!)
            

           return cell
        }
    
    }
    }
  
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        self.rating.setTitle(("rating").localiz(), for: .normal)
        
        if accounttype == "4"{
            designFooter()
        }
        dump(self.detail)
           momId = KeychainWrapper.standard.string(forKey: "uid")!
        
         let tit = self.detail?.title
       self.title =  tit?.trimmingCharacters(in: .whitespaces)
         
        // let data =  filterObjData(momId : momId, type : self.type, type_id : self.type_id, nid : self.nid)
        
      //  print("ddd")
      // print(momId)
      //  print(self.type)
      ///  print(self.type_id)
       // print(self.nid)
      // print("ddd")
//        let photo = UIImageView.self
     
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
        
//        if type == "milestone"{
//            URL_GET_DATA = functions.apiLink()+functions.lang()+"/milestone.json?uid="+child_id
//        }
//        else if type == "feeding"  || type == "parent" || type == "brain"{
//            URL_GET_DATA = functions.apiLink()+functions.lang()+"/tips.json/\(type_id)?uid="+child_id
//        }else{
//            URL_GET_DATA = functions.apiLink()+functions.lang()+"/milestone.json"
//        }
      /*
        
        Alamofire.request(URL_GET_DATA).responseJSON { response in
            
            //getting json
            if let json = response.result.value {
                
                //converting json to NSArray
                let dataArray : NSArray  = json as! NSArray
                
                //traversing through all elements of the array
                for i in 0..<dataArray.count{
                    
                    //adding hero values to the hero list
                    self.data.append(Dataserver(
                        title: (dataArray[i] as AnyObject).value(forKey: "title") as? String,
                        nid: (dataArray[i] as AnyObject).value(forKey: "nid") as? String,
                        thumb_image: (dataArray[i] as AnyObject).value(forKey: "thumb_image") as? String,
                        age: (dataArray[i] as AnyObject).value(forKey: "age") as? String,
                        image: (dataArray[i] as AnyObject).value(forKey: "image") as? String,
                        current_uid: (dataArray[i] as AnyObject).value(forKey: "current_uid") as? String,
                        isFlagged: (dataArray[i] as AnyObject).value(forKey: "isFlagged") as? String,
                        rate_average: (dataArray[i] as AnyObject).value(forKey: "rate_average") as? String
                    ))
                    
                }
                //print("aaaaaaaself.data.count")
                //print(self.data.count)
                
                self.usedData = self.data
                
                self.tableView.reloadData()
            }
            
        }
        
   */
        
}
    
    
    
    func filterObjData(momId : String, type : String, type_id : Int, nid : String) -> [Dataserver]{
        
        let data = serverConnection(momId : momId, type : type, type_id : type_id)
        return data.filter { $0.nid == nid}
        
    }
    
    
    
    func serverConnection(momId : String, type : String, type_id : Int) -> [Dataserver] {
        var URL_GET_DATA : String = ""
        let functions = Functions()
        var data = [Dataserver]()
        
        if type == "favourite"{
            URL_GET_DATA = functions.apiLink()+"apis/favourite.php?uid="+momId
        }else if type == "milestone"{
            URL_GET_DATA = functions.apiLink()+functions.lang()+"/milestone.json?uid="+momId
        }
        else if type == "feeding"  || type == "parent" || type == "brain"{
            URL_GET_DATA = functions.apiLink()+functions.lang()+"/tips.json/\(type_id)?uid="+momId
        }
            
        else if type == "video" {
            URL_GET_DATA = functions.apiLink()+"videos.json/?uid="+momId
        }
        else{
            URL_GET_DATA = functions.apiLink()+functions.lang()+"/milestone.json"
        }
   
        
        Alamofire.request(URL_GET_DATA).responseJSON { response in
            
            if let val = response.result.value {
                let json = JSON(val)
                
                for i in 0..<json.count{
                    
                    data.append(Dataserver(
                        
                        
                        title: json[i]["title"].string,
                        nid: json[i]["nid"].string,
                        thumb_image: json[i]["thumb_image"].string,
                        age: json[i]["age"].string,
                        image: json[i]["image"].string,
                        current_uid: json[i]["current_uid"].string,
                        isFlagged: json[i]["isFlagged"].string,
                        rate_average: json[i]["rate_average"].string,
                        youtube_id: json[i]["youtube_id"].string,
                        
                        p1: json[i]["grouping_votes"]["p1"].int!,
                        p2: json[i]["grouping_votes"]["p2"].int!,
                        p3: json[i]["grouping_votes"]["p3"].int!,
                        p4: json[i]["grouping_votes"]["p4"].int!,
                        p5: json[i]["grouping_votes"]["p5"].int!,
                        count_user_rate: json[i]["count_user_rate"].string!,
                        
                        is_rate: json[i]["is_rate"].string,
                        rate_value: json[i]["rate_value"].string
                    ))
                    
                }
                
                
            }
            
            
        }
        
        return data
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
