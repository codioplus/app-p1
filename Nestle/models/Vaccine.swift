//
//  Vaccine.swift
//  Nestle
//
//  Created by User on 5/11/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import Foundation

class Vaccine {
    
    var title: String?
    var arabic_name: String?
    var thumb_image: String?
    var body: String?
    var arabic_body: String?
    var country: String?
    var nid: Int?
    var age: Int?
    var vaccine_id: Int?
    var kid_id: Int?
    var vaccine_kid: Int64?
    var hospital: String?
    var completed: String?
    var planned: String?
    var completed_date: String?
    var type: String?
    var month_nb: Int?
    
    init(
    title: String?,
    arabic_name: String?,
    thumb_image: String?,
    body: String?,
    arabic_body: String?,
    country: String?,
    nid: String?,
    age: String?,
    vaccine_id: String?,
    kid_id: String?,
    vaccine_kid: String?,
    hospital: String?,
    completed: String?,
    planned: String?,
    completed_date: String?,
    type: String?,
    month_nb: Int?
        ) {
       

        self.title = title
        self.arabic_name = arabic_name
        self.thumb_image = thumb_image
        self.body = body
        self.arabic_body = arabic_body
        self.country = country
        self.nid =  Int(nid!)
        self.age = Int(age!)
        self.vaccine_id = Int(vaccine_id!)
        self.kid_id =  Int(kid_id!)
        self.vaccine_kid = Int64(vaccine_kid!)
        self.hospital = hospital
        self.completed = completed
        self.planned = planned
        self.completed_date = completed_date
        self.type = type
        self.month_nb = month_nb
    
    }
    
    
}
