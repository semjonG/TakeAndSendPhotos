//
//  RootConfigurator.swift
//  TakeAndSendPhotos
//
//  Created by mac on 10.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
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
