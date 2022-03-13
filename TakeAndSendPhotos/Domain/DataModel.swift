//
//  File.swift
//  TakeAndSendPhotos
//
//  Created by mac on 06.03.2022.
//

import Foundation
import RealmSwift

class DataModel: Object {
    
    @Persisted var id: String = ""
    @Persisted var name: String = ""
    @Persisted var created: Date
    @Persisted var send: Date
}

protocol DataManagerProtocol {
//    func addToRalm()
}

class DataManager: DataManagerProtocol {
    
    let realm = try! Realm()
    let chosenPhotos: Array<DataModel> = []
    var resultsFromRealm: Results<DataModel>!
    
    func saveToRealm(chosenPhotos: [DataModel]) {
        try! realm.write {
            realm.add(chosenPhotos)
        }
    }
}
