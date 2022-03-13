//
//  KeyChainManager.swift
//  TakeAndSendPhotos
//
//  Created by mac on 10.03.2022.
//

import Locksmith

class KeychainManager {

    func saveToKeychain(login:String, password: String) {
        do {
            try Locksmith.saveData(data: ["login" : login, "password" : password], forUserAccount: "MyAccount")
        } catch {
            print("Unable to save data")
        }
    }
    
    func save(key: String, value: Any) {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: "MyAccount")
            try Locksmith.saveData(data: [key : value], forUserAccount: "MyAccount")
        } catch {
            print("Unable to save data")
        }
    }
    
    func get(key: String) -> Any? {
        dictionary![key]
    }
    
    // загрузка из keychain
    let dictionary = Locksmith.loadDataForUserAccount(userAccount: "MyAccount")
}


