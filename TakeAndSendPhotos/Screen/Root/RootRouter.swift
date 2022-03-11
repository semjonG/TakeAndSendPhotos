//
//  RootRouter.swift
//  TakeAndSendPhotos
//
//  Created by mac on 10.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol RootRoutable: ViewRoutable {
    func routeToPhoto()
}

class RootRouter {
    
    // MARK: Injections
    weak var viewController: UIViewController?
    
    // MARK: LifeCycle
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}

// MARK: - RootRoutable
extension RootRouter: RootRoutable {
    func routeToPhoto() {
        let vc = PhotoViewController()
        
        viewController?.present(vc, animated: true, completion: nil)
    }
}
