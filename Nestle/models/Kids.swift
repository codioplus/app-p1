//
//  Kids.swift
//  Nestle
//
//  Created by User on 5/4/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import Foundation
class Kids {
    
    var title: String?
    var dob: String?
    var profile_image: String?
    var child_id: String?
    var gender: String?
    init(title: String?, dob: String?, profile_image: String?, child_id:String?, gender: String?) {
        self.title = title
        self.dob = dob
        self.profile_image = profile_image
        self.child_id = child_id
        self.gender = gender
    }
}
