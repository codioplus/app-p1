//
//  Shoutout.swift
//  Nestle
//
//  Created by User on 6/4/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import Foundation
import ObjectMapper
class Shoutout : Mappable {
    var title : String?
    var body : String?
    var doctor_id : Int?
    var image : String?
    var date : String?
    var nid : Int?
    var kid_id : Int?
    var type : Int?
     required init?(
map:Map
        ){
    }
        
func mapping(map: Map){
        title <- map["title"]
        body <- map["body"]
        doctor_id <- map["doctor_id"]
        image <- map["image"]
       date <- map["date"]
       nid <- map["nid"]
        kid_id <- map["kid_id"]
       type <- map["type"]
    }
    
}
