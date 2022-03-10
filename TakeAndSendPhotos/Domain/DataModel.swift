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

// доработать датамэнаджер, найти шаблонное решение 
class DataManager: DataManagerProtocol {
    
    
//    let realm = try! Realm()
//    lazy var categories: Results<Category> = { self.realm.objects(Category) }()
//
//    func addToRalm() {
//        if categories.count == 0 { // 1
//
//           try! realm.write() { // 2
//
//            let defaultCategories = ["Birds", "Mammals", "Flora", "Reptiles", "Arachnids" ] // 3
//
//            for category in defaultCategories { // 4
////              let newCategory = Category()
//              newCategory.name = category
//              self.realm.add(newCategory)
//            }
//          }
//
////          categories = realm.objects(Category) // 5
//        }
//
//    }
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
