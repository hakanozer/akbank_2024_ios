//
//  Util.swift
//  Product
//
//  Created by HAKAN ÖZER on 28.02.2024.
//

import Foundation

class Util {
    
    // SQLite file Path
    static let sqlitePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!)/db.sqlite3"
    
    // Store UserModel
    static func userStore( data: UserModel ) {
        if let jsonUserModel = try? JSONEncoder().encode(data) {
            UserDefaults.standard.setValue(jsonUserModel, forKey: "user")
            UserDefaults.standard.synchronize()
        }
    }
    
    static func userGet() -> UserModel? {
        if let dtUser = UserDefaults.standard.object(forKey: "user") as? Data {
            UserDefaults.standard.synchronize()
            if let userModel = try? JSONDecoder().decode(UserModel.self, from: dtUser) {
                return userModel
            }
        }
        return nil
    }
    
    
}
