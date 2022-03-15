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
            self.dataManager.saveToRealm(photo: ImageFileModel(id: UUID().uuidString))
        }
        
        
        
        let dispatchGroup = DispatchGroup()
        for item in chosenPhoto {
            dispatchGroup.enter()
            networkManager.uploadImage(image: item) { res in
                self.dataManager.updateToRealm(send: Date())
                dispatchGroup.leave()
            }
        }
        
//        let data = NSData(data: UIImageJPEGRepresentation(chosenPhoto: [UIImage],0.9))
        dispatchGroup.notify(queue: .main) {
            print("all tasks upload")
//            dataManager.saveToRealm(chosenPhotos: List<DataModel>)
        }
    }
    
    func viewDidLoad() {
        
    }
    
}

