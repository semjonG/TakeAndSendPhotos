//
//  PhotoPresenter.swift
//  TakeAndSendPhotos
//
//  Created by mac on 11.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol PhotoPresenterInput: BasePresenterInput {
    
    var router: PhotoRoutable { get }
    
}

protocol PhotoPresenterOutput: BasePresenterOutput {
    
}

class PhotoPresenter {
    
    //MARK: Injections
    private weak var output: PhotoPresenterOutput?
    var router: PhotoRoutable
    
    //MARK: LifeCycle 
    init(output: PhotoPresenterOutput,
         router: PhotoRoutable) {
        
        self.output = output
        self.router = router
    }
    
}

// MARK: - PhotoPresenterInput
extension PhotoPresenter: PhotoPresenterInput {
    
    func viewDidLoad() {
        
    }
    
}

