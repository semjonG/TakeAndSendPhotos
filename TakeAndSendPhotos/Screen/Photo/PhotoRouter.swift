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
        
        let uiVC = PhotoViewController()

        let dialogMessage = UIAlertController(title: "Success!", message: "Data has been sent to the server", preferredStyle: .alert)

        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
         })

        dialogMessage.addAction(ok)
        
        uiVC.present(dialogMessage, animated: true, completion: nil)
    }
}
