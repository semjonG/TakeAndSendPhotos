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
    func write()
}
// доработать датамэнаджер, найти шаблонное решение 
class DataManager: DataManagerProtocol {
    func write() {
//        написать функционал записи
    }
    
    let realm = try! Realm()
    
    
}

////    экземпляр
//let realm = try! Realm()
//
////    массив для хранения всех значений в базе данных и через него производим чтение и запись данных
//var photoArray: Results<DataModel>!
//
//var token: NotificationToken?
//
//try! realm.write {
//    realm.add(<#T##object: Object##Object#>)
//}
