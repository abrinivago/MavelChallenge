//
//  UserSession.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 16/03/2022.
//

import Foundation

struct UserSession {
    
    static var sessionVerify: UserSession? {
        
        let userDefaults = UserDefaults.standard
        guard let uid = userDefaults.object(forKey: "UID") as? String else {
            print("entro por no tener uid")
            return nil
        }
        return UserSession(uid: uid)
    }
    
    func closeSession() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "UID")
        userDefaults.synchronize()
        print("se elimino el uid")
    }
    
    var uid: String {
        let userDefaults = UserDefaults.standard
        let uid = userDefaults.object(forKey: "UID") as? String
        return uid ?? ""
    }
    
    fileprivate init(uid: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(uid, forKey: "UID")
        userDefaults.synchronize()
    }
}


extension UserSession {
    
    @discardableResult static func buildWithUid(_ uid: String) -> UserSession {
        
        let session = UserSession(uid: uid)
        return session
    }
}

