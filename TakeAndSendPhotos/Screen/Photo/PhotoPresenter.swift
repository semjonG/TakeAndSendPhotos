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
        
            // saving and creating information about data
            self.dataManager.saveToRealm(
                photo: ImageFileModel(id: UUID().uuidString,
                                      name: "Random id: \(String.random())", 
                                      created: Date(),
                                      data: data as Data,
                                      send: nil)
            )
        }
        
        let dispatchGroup = DispatchGroup()
        for item in self.dataManager.getAllImages() {
            dispatchGroup.enter()
            
            // sending data
            networkManager.uploadImage(image: item.data!) { res in
                
                // updating data
                DispatchQueue.main.async {
                    self.dataManager.updateToRealm(photoID: item.id)
                    dispatchGroup.leave()
                }
            }
        }
      
        dispatchGroup.notify(queue: .main) {
            self.router.showSuccessAlert()
            let data = self.dataManager.getAllImages()
            for item in data {
                print(item.send)
            }
        }
    }
    
    func viewDidLoad() {
        
        let data = dataManager.getAllImages()
        let items = data.filter { $0.send == nil}
        if !items.isEmpty {
            let dispatchGroup = DispatchGroup()
            for item in self.dataManager.getAllImages() {
                dispatchGroup.enter()
                
                // sending data
                networkManager.uploadImage(image: item.data!) { res in
                    
                    // updating data
                    DispatchQueue.main.async {
                        self.dataManager.updateToRealm(photoID: item.id)
                        dispatchGroup.leave()
                    }
                }
            }
    
            dispatchGroup.notify(queue: .main) {
                self.router.showSuccessAlert()
                let data = self.dataManager.getAllImages()
                for item in data {
                    print(item.send)
                }
            }
        }
    }
}

extension String {

    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
