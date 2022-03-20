//
//  PhotoRouter.swift
//  TakeAndSendPhotos
//
//  Created by mac on 11.03.2022.
//

import UIKit

protocol PhotoRoutable: ViewRoutable {
    func showSuccessAlert()
}

class PhotoRouter {
    
    // MARK: Injections
    weak var viewController: UIViewController?
    
    // MARK: LifeCycle
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}

// MARK: - PhotoRoutable
extension PhotoRouter: PhotoRoutable {
    func showSuccessAlert() {
        // mark
    }
}
