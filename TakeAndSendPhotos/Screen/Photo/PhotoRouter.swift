//
//  PhotoRouter.swift
//  TakeAndSendPhotos
//
//  Created by mac on 11.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PhotoRoutable: ViewRoutable {
    
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
    
}
