//
//  PhotoPresenter.swift
//  TakeAndSendPhotos
//
//  Created by mac on 11.03.2022.
//
import RealmSwift
import UIKit

protocol PhotoPresenterInput: BasePresenterInput {
    
    var router: PhotoRoutable { get }
    func set(chosenPhoto: [UIImage])
}

protocol PhotoPresenterOutput: BasePresenterOutput {
    
}

class PhotoPresenter {
    
    //MARK: Injections
    private weak var output: PhotoPresenterOutput?
    var router: PhotoRoutable
    var networkManager = NetworkManager()
    var dataManager = DataManager()
    
    //MARK: LifeCycle 
    init(output: PhotoPresenterOutput,
         router: PhotoRoutable) {
        
        self.output = output
        self.router = router
    }
}

// MARK: - PhotoPresenterInput
extension PhotoPresenter: PhotoPresenterInput {
    func set(chosenPhoto: [UIImage]) {
        let dataArray = chosenPhoto.map { NSData(data: $0.jpegData(compressionQuality: 0.9)!) }
        dataArray.forEach { data in
            
//            фиксируем информацию о создании "посылки"
//            self.dataManager.saveToRealm(photo: ImageFileModel(id: UUID().uuidString, name: String, created: Date, data: Data, send: nil))
        }
        
        let dispatchGroup = DispatchGroup()
        for item in chosenPhoto {
            dispatchGroup.enter()
//            отправка "посылки"
            networkManager.uploadImage(image: item) { res in
                
                // фиксируем дату и время "получения посылки"
//                self.dataManager.updateToRealm(photoID: Date())
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("all tasks upload")
        }
    }
    
    func viewDidLoad() {
        
    }
    
}

