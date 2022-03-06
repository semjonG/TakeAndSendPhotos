//
//  Network.swift
//  TakeAndSendPhotos
//
//  Created by mac on 06.03.2022.
//

import UIKit
import Alamofire

// HTTP (CRUD)
protocol NetworkProcol {
    func get()
}
// доработать нетворкмэнаджер, найти шаблонное решение (функционал по CRUD) 
class NetworkManager {
    
    private let url = "https://test.dewival.com/api/login/"
    
    func authorization(url: String) {
        AF.request(url).response
    }
     
}
