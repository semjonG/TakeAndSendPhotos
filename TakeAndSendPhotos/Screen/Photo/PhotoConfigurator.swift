//
//  PhotoConfigurator.swift
//  TakeAndSendPhotos
//
//  Created by mac on 11.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PhotoConfigurable {
    func configure(viewController: PhotoViewController)
}

class PhotoConfigurator: PhotoConfigurable {

    //MARK: PhotoConfigurable
    func configure(viewController: PhotoViewController) {
    
        let router = PhotoRouter(viewController: viewController)
        
        let presenter = PhotoPresenter(
            output: viewController,
            router: router
        )
        
        viewController.presenter = presenter

    }
}
