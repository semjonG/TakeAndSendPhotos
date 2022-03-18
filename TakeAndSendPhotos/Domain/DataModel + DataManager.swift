//
//  File.swift
//  TakeAndSendPhotos
//
//  Created by mac on 06.03.2022.
//

import RealmSwift

class ImageFileModel: Object {
    @Persisted var id: String = ""
    @Persisted var name: String = ""
    @Persisted var created: Date // time create
    @Persisted var data: Data
    @Persisted var send: Date? // time to send
    
    init(id: String, name: String, created: Date, data: Data, send: Date?) {
        self.id = id
        self.name = name
        self.created = created
        self.data = data
        self.send = send
    }
}

protocol DataManagerProtocol {
    func saveToRealm(photo: ImageFileModel)
//    func getAllImages() -> [ImageFileModel]
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
    
//    func getAllImages() -> [ImageFileModel] {
//        try! realm.objects(ImageFileModel.self)
//    }
    

}
