//
//  Menu.swift
//  Nestle
//
//  Created by User on 5/7/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import Foundation
class Menu {
    
    var title: String?
    var dob: String?
    var profile_image: String?
    var child_id: String?
    
    init(title: String?, dob: String?, profile_image: String?, child_id:String?) {
        self.title = title
        self.dob = dob
        self.profile_image = profile_image
        self.child_id = child_id
    }
}

