//
//  RootConfigurator.swift
//  TakeAndSendPhotos
//
//  Created by mac on 10.03.2022.
//

import UIKit

protocol RootConfigurable {
    func configure(viewController: RootViewController)
}

class RootConfigurator: RootConfigurable {

    //MARK: RootConfigurable
    func configure(viewController: RootViewController) {
    
        let router = RootRouter(viewController: viewController)
        
        let presenter = RootPresenter(
            output: viewController,
            router: router
        )
        
        viewController.presenter = presenter

    }
}
