//
//  App.swift
//  yousters-subs
//
//  Created by Ян Мелоян on 13.06.2020.
//  Copyright © 2020 molidl. All rights reserved.
//

import Foundation
import UIKit

class App {
    private init() {
        token = SaveRestoreProvider.shared.restoreToken()
        userName = SaveRestoreProvider.shared.restoreUser()
    }
    
    static let shared = App()
    
    var token:String? {
        didSet {
            SaveRestoreProvider.shared.saveToken(token: token)
        }
    }
    
    var userName:String? {
        didSet {
            SaveRestoreProvider.shared.saveUserName(name: userName)
        }
    }
    
    func logOut(topController:UIViewController? = nil) {        
        token = nil
        userName = nil
        
        let vc = RouteProvider.shared.firstEnterView()
        RouteProvider.switchRootViewController(rootViewController: vc, animated: true, completion: nil)
        
    }
    
    var isNeedUpdateEvents = false
}
