//
//  Families.swift
//  Nestle
//
//  Created by User on 5/31/18.
//  Copyright © 2018 Nestle. All rights reserved.
//



import Foundation
import ObjectMapper
class Families : Mappable {
    
    var mom_ref : String?
    var uid : String?
    var country_name : String?
    var country_name_ar : String?
    var country_id : String?
    var doctor_id : String?
    var doctor_name : String?
    var doctor_ref : String?
    var profile_image : String?
    var mom_name : String?
    var kid : [Kid]?
    
    required init?(
        map:Map
//
//    mom_ref : String?,
//    uid : String?,
//    country_name : String?,
//    country_name_ar : String?,
//    country_id : String?,
//    doctor_id : String?,
//    doctor_name : String?,
//    doctor_ref : String?,
//    profile_image : String?,
//    mom_name : String?,
//    kid : [Kid]?

        ) {
        
    }
    
      func mapping(map: Map){
    
        mom_ref <- map["mom_ref"]
        uid <- map["uid"]
        country_name <- map["country_name"]
        country_name_ar <- map["country_name_ar"]
        country_id <- map["country_id"]
        doctor_id <-  map["doctor_id"]
        doctor_name <- map["doctor_name"]
        doctor_ref <- map["doctor_ref"]
        profile_image <-  map["profile_image"]
        mom_name <-  map["mom_name"]
        kid <- map["kid"]
  
    }
   
}

