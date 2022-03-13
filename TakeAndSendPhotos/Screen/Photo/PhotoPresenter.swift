//
//  PhotoPresenter.swift
//  TakeAndSendPhotos
//
//  Created by mac on 11.03.2022.
//

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
        
        let dispatchGroup = DispatchGroup()
        for item in chosenPhoto {
            dispatchGroup.enter()
            networkManager.uploadImage(image: item) { res in
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("all tasks upload")
//            DataManager.chosenPhotos 
        }
    }
    
    func viewDidLoad() {
        
    }
    
}

