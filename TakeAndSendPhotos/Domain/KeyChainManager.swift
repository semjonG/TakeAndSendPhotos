//
//  KeyChainManager.swift
//  TakeAndSendPhotos
//
//  Created by mac on 10.03.2022.
//

import Foundation
import KeychainSwift

class KeychainHelper {
    // safe token
    static let shared = KeychainHelper()
    private init() {}
        
    func set(value: String, key: String) {
        let keychainswift = KeychainSwift()
        
        keychainswift.set(value, forKey: key)
//        let query = [
//               kSecValueData: data,
//               kSecClass: kSecClassGenericPassword,
//               kSecAttrService: service,
//               kSecAttrAccount: account,
//           ] as CFDictionary
//
//           // Add data in query to keychain
//           let status = SecItemAdd(query, nil)
//
//           if status != errSecSuccess {
//               // Print out the error
//               print("Error: \(status)")
//           }
    }
}
