//
//  EventService.swift
//  DoctorApp
//
//  Created by Ян Мелоян on 11.08.2020.
//  Copyright © 2020 mika. All rights reserved.
//

import Alamofire
import SwiftyJSON
import SwiftDate

class EventService: YoustersNetwork {
        
    func getEvents(complition: @escaping ([Event])->Void) {
        
        guard let headers = getHTTPHeaders(rawHeaders: basicHeaders) else {
            complition([])
            return
        }
        
        AF.request(URLs.getEvents, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                
                var result = [Event]()
                for item in json.arrayValue {
                    result.append(Event(data: item))
                }
                complition(result.reversed())
            case .failure(let error):
                debugPrint(error)
                complition([])
            }
        }
    }
    
    func createEvent(event:Event, complition: @escaping (Bool)->Void) {
        
        guard let headers = getHTTPHeaders(rawHeaders: basicHeaders) else {
            complition(false)
            return
        }
        
        let parameters =  ["doctor" : event.doctorName,
                           "title" : event.title,
                           "description" : event.desc,
                           "start_time": event.startTime
        ]
        
        
        AF.request(URLs.createEvent, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            //print(response.debugDescription)
            switch response.result {
            case .success( _):
                complition(true)
                App.shared.isNeedUpdateEvents = true
            case .failure(let error):
                debugPrint(error)
                complition(false)
            }
        }
    }
    
    func getServices(complition: @escaping ([Service])->Void) {
        
        guard let headers = getHTTPHeaders(rawHeaders: basicHeaders) else {
            complition([])
            return
        }
        
        AF.request(URLs.getServices, method: .get, headers: headers).responseJSON { response in
            //print(response.debugDescription)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var result = [Service]()
                for item in json.arrayValue {
                    result.append(Service(data: item))
                }
                //print(json)
                complition(result)
            case .failure(let error):
                debugPrint(error)
                complition([])
            }
        }
    }
        
    static let main = EventService()
    
    override private init() {}
}
