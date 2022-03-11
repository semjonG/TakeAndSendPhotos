//
//  PhotoViewController.swift
//  TakeAndSendPhotos
//
//  Created by mac on 11.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    // MARK: Outlets
    
    // MARK: Injections
    var presenter: PhotoPresenterInput!
    var configurator: PhotoConfigurable!

    // MARK: View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configurator = PhotoConfigurator()
        configurator.configure(viewController: self)
        presenter.viewDidLoad()
        
    }

}

// MARK: - PhotoPresenterOutput
extension PhotoViewController: PhotoPresenterOutput {

}
