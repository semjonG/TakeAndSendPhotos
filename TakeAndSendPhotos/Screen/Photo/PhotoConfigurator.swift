//
//  PhotoConfigurator.swift
//  TakeAndSendPhotos
//
//  Created by mac on 11.03.2022.
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
