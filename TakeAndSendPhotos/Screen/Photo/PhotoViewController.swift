//
//  PhotoViewController.swift
//  TakeAndSendPhotos
//
//  Created by mac on 11.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import ImagePicker

class PhotoViewController: UIViewController, ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        presenter.set(chosenPhoto: images)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        
    }
    
    
    private var imagePicker = UIImagePickerController()
    
    // MARK: Outlets
    
    lazy var pickImagesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pick images", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(pickImageButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.text = "Pick 3 images"
        return label
    }()
    
    // MARK: Injections
    var presenter: PhotoPresenterInput!
    var configurator: PhotoConfigurable!

    // MARK: View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(textLabel)
        view.addSubview(pickImagesButton)
        
        NSLayoutConstraint.activate([
            
            textLabel.widthAnchor.constraint(equalToConstant: 100),
            textLabel.heightAnchor.constraint(equalToConstant: 40),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pickImagesButton.widthAnchor.constraint(equalToConstant: 100),
            pickImagesButton.heightAnchor.constraint(equalToConstant: 40),
            pickImagesButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
            pickImagesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
        
        configurator = PhotoConfigurator()
        configurator.configure(viewController: self)
        presenter.viewDidLoad()
        
    }
    
    @objc func pickImageButtonPressed() {
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        present(imagePicker, animated: true, completion: nil)
    }

}

// MARK: - PhotoPresenterOutput
extension PhotoViewController: PhotoPresenterOutput {

}

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
        }
        dismiss(animated: true, completion: nil)
    }
}
