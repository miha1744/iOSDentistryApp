//
//  DoctorService.swift
//  DoctorApp
//
//  Created by Ян Мелоян on 19.08.2020.
//  Copyright © 2020 mika. All rights reserved.
//

import Alamofire
import SwiftyJSON
import SwiftDate

class DoctorService: YoustersNetwork {
    
    func getDocs(complition: @escaping ([Doctor])->Void) {
        
        guard let headers = getHTTPHeaders(rawHeaders: basicHeaders) else {
            complition([])
            return
        }
        
        AF.request(URLs.getDocs, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                
                var result = [Doctor]()
                for item in json.arrayValue {
                    result.append(Doctor(data: item))
                }
                //print(json)
                complition(result)
            case .failure(let error):
                debugPrint(error)
                complition([])
            }
        }
    }
    
    func getDocEvents(pk:String, complition: @escaping ([Event])->Void) {
        
        guard let headers = getHTTPHeaders(rawHeaders: basicHeaders) else {
            complition([])
            return
        }
        
        AF.request(URLs.getDoctorEvent(pk: pk), method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                
                var result = [Event]()
                for item in json.arrayValue {
                    result.append(Event(data: item))
                }
                print(json)
                complition(result)
            case .failure(let error):
                debugPrint(error)
                complition([])
            }
        }
    }
        
    static let main = DoctorService()
    
    override private init() {}
}
