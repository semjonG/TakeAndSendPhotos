//
//  RootPresenter.swift
//  TakeAndSendPhotos
//
//  Created by mac on 10.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol RootPresenterInput: BasePresenterInput {
    
    var router: RootRoutable { get }
    func onLogin(email: String, password: String)
}

protocol RootPresenterOutput: BasePresenterOutput {
    
}

class RootPresenter {
    
    //MARK: Injections
    private weak var output: RootPresenterOutput?
    var router: RootRoutable
    var networkManager = NetworkManager()
    
    //MARK: LifeCycle 
    init(output: RootPresenterOutput,
         router: RootRoutable) {
        
        self.output = output
        self.router = router
    }
    
}

// MARK: - RootPresenterInput
extension RootPresenter: RootPresenterInput {
    
    func viewDidLoad() {
        
    }
    
    func onLogin(email: String, password: String) {
        networkManager.logIn(email: email, password: password) { result in
            print("test")
        }
        // Netwok
    }
}

