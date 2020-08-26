//
//  AuthService.swift
//  yousters-subs
//
//  Created by Ян Мелоян on 08.06.2020.
//  Copyright © 2020 molidl. All rights reserved.
//

import Alamofire
import SwiftyJSON

class AuthService: YoustersNetwork {
        
    func auth(login:String, pass:String, complition: @escaping (Bool)->Void) {
        let parameters = ["username" : login, "password" : pass]
        AF.request(URLs.auth, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let token = json["token"].stringValue
                print(json)
                App.shared.token = token
                complition(true)
            case .failure(let error):
                debugPrint(error)
                complition(false)
            }
            
        }
    }
    
    func register(name:String, login:String, pass:String, complition: @escaping (Bool)->Void) {
        let parameters = ["name" : name, "user" : ["username":login, "password" : pass]] as [String : Any]
        AF.request(URLs.register, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                if json["pk"].stringValue != "" {
                    Self.main.auth(login: login, pass: pass) { (result) in
                        if result {
                            complition(true)
                        } else {
                            complition(false)
                        }
                    }
                }
            case .failure(let error):
                debugPrint(error)
                complition(false)
            }
            
        }
    }
    
    func me() {
        guard let headers = getHTTPHeaders(rawHeaders: basicHeaders) else { return }
        
        AF.request(URLs.me, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                App.shared.userName = json["name"].stringValue
                //print(json)
                
            case .failure(let error):
                debugPrint(error)
            }
            
        }
    }
        
    static let main = AuthService()
    
    override private init() {}
}
