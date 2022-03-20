//
//  File.swift
//  TakeAndSendPhotos
//
//  Created by mac on 06.03.2022.
//

import RealmSwift

class ImageFileModel: Object {
    @objc  dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var created: Date = Date()  // time create
    @objc dynamic var data: Data? = nil
    @objc dynamic var send: Date? = nil // time to send
    
    convenience init(id: String, name: String, created: Date, data: Data, send: Date?) {
        self.init()
        self.id = id
        self.name = name
        self.created = created
        self.data = data
        self.send = send
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

protocol DataManagerProtocol {
    func saveToRealm(photo: ImageFileModel)
}

class DataManager: DataManagerProtocol {
    
    lazy var realm = try! Realm()
    
    func saveToRealm(photo: ImageFileModel) {
        try! realm.write {
            realm.add(photo)
        }
    }
    
    func updateToRealm(photoID: String) {
        let persons = realm.object(ofType: ImageFileModel.self, forPrimaryKey: photoID)
        try! realm.write {
            persons?.setValue(Date(), forKey: "send")
        }
    }
    
    func getAllImages() -> [ImageFileModel] {
        let result = try? realm.objects(ImageFileModel.self)
        return result == nil ? [] : Array(result!)
    }
}
