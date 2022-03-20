//
//  PhotoViewController.swift
//  TakeAndSendPhotos
//
//  Created by mac on 11.03.2022.
//

import UIKit
import ImagePicker

class PhotoViewController: UIViewController, ImagePickerDelegate {

    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {}
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        presenter.set(chosenPhoto: images)
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {}
    
    private var imagePicker = UIImagePickerController()
    
    // MARK: Outlets
    
    private lazy var pickImagesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pick images", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(pickImageButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
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
            
            pickImagesButton.widthAnchor.constraint(equalToConstant: 150),
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
    }
}

// MARK: - PhotoPresenterOutput
extension PhotoViewController: PhotoPresenterOutput {

}

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        dismiss(animated: true, completion: nil)
    }
}
