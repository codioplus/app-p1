//
//  Dataserver.swift
//  Nestle
//
//  Created by User on 5/7/18.
//  Copyright © 2018 Nestle. All rights reserved.
//


import Foundation


class Dataserver {
    
    var title: String?
    var nid: String?
    var thumb_image: String?
    var age: Int?
    var image: String?
    var current_uid: String?
    var isFlagged: String?
    var rate_average: Double?
    var p1: Int
    var p2: Int
    var p3: Int
    var p4: Int
    var p5: Int
    var count_user_rate: String
    var youtube_id: String?
    var is_rate: String?
    var rate_value: String?
    init(title: String?, nid: String?, thumb_image: String?, age:String?, image:String?, current_uid:String?, isFlagged:String?, rate_average:String?, youtube_id: String?, p1: Int, p2: Int, p3: Int, p4: Int, p5: Int, count_user_rate: String, is_rate: String?, rate_value: String?) {
        
        
        self.title = title
        self.nid = nid
        self.thumb_image = thumb_image
        self.age = Int(age!)
        self.image = image
        self.current_uid = current_uid
        self.isFlagged = isFlagged
        self.rate_average = Double(rate_average!)
        self.youtube_id = youtube_id

        self.p1 = p1
        self.p2 = p2
        self.p3 = p3
        self.p4 = p4
        self.p5 = p5
        self.count_user_rate = count_user_rate
        self.is_rate = is_rate
        self.rate_value = rate_value
        
        
        
        
    }
    
    
  
}
