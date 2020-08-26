//
//  Event.swift
//  DoctorApp
//
//  Created by Ян Мелоян on 11.08.2020.
//  Copyright © 2020 mika. All rights reserved.
//

import SwiftyJSON
import SwiftDate

struct Event {
    var title:String, desc:String, startTime:String, doctorName:String
    
    init(data:JSON) {
        title = data["title"].stringValue
        desc = data["description"].stringValue
        startTime = data["start_time"].stringValue
        doctorName = data["doctor"].stringValue
    }
    
    init(title:String, desc:String, startTime:String, doctorName:String) {
        self.title = title
        self.desc = desc
        self.startTime = startTime
        self.doctorName = doctorName
    }
    
    func getPeriod() -> String {
        let startTimeString = startTime.toISODate()!.toFormat("dd MMM 'в' HH:mm", locale: Locales.russian)

        return startTimeString
    }
}
