//
//  SaveRestoreProvider.swift
//  yousters-subs
//
//  Created by Ян Мелоян on 13.06.2020.
//  Copyright © 2020 molidl. All rights reserved.
//

import Foundation

class SaveRestoreProvider {
    
    private static let tokenKey = "tokenKey"
    private static let baseUserKey = "userKey"
    
    private init() {}
    
    static let shared = SaveRestoreProvider()
    
    func saveToken(token:String?) {
        UserDefaults.standard.set(token, forKey: Self.tokenKey)
    }
    
    
    func restoreToken() -> String? {
        print(UserDefaults.standard.string(forKey: Self.tokenKey))
        return UserDefaults.standard.string(forKey: Self.tokenKey)
    }
    
    func saveUserName(name:String?) {
        UserDefaults.standard.set(name, forKey: Self.baseUserKey)
    }
    
    func restoreUser() -> String? {
        UserDefaults.standard.string(forKey: Self.baseUserKey)
        
    }
}
