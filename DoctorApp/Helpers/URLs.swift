//
//  URLs.swift
//  yousters-subs
//
//  Created by Ян Мелоян on 12.06.2020.
//  Copyright © 2020 molidl. All rights reserved.
//

import Foundation

struct URLs {
    static let base = "https://pacific-peak-05684.herokuapp.com/"
    static let baseAPI = "\(base)api/v1/"
    
    static let auth = "\(base)api-token-auth"
    static let register = "\(baseAPI)register"
    static let me = "\(baseAPI)patient_info"
    
    static let getEvents = "\(baseAPI)current_user_events"
    static let getDocs = "\(baseAPI)doctors-list"
    
    static let getServices = "\(baseAPI)services"
    
    static let createEvent = "\(baseAPI)register-event"
    
    static func getDoctorEvent(pk:String) -> String {
        "\(baseAPI)events/\(pk)"
    }
}
