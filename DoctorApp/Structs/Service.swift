//
//  Service.swift
//  DoctorApp
//
//  Created by Ян Мелоян on 19.08.2020.
//  Copyright © 2020 mika. All rights reserved.
//

import SwiftyJSON

struct Service {
    var title:String, desc:String
    
    init(data:JSON) {
        title = data["title"].stringValue
        desc = data["description"].stringValue
    }
}
