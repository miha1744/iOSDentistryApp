//
//  Doctor.swift
//  DoctorApp
//
//  Created by Ян Мелоян on 11.08.2020.
//  Copyright © 2020 mika. All rights reserved.
//

import SwiftyJSON

struct Doctor {
    var pk:String, name:String, prof:String, avaURL:String
    
    init(data:JSON) {
        pk = data["pk"].stringValue
        name = data["name"].stringValue
        avaURL = data["image"].stringValue
        prof = data["profession"].stringValue
    }
}
