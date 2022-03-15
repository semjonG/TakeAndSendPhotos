//
//  PhotoViewController.swift
//  TakeAndSendPhotos
//
//  Created by mac on 11.03.2022.
//

import UIKit
import ImagePicker

class PhotoViewController: UIViewController, ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        presenter.set(chosenPhoto: images)
//        imagePicker.
//        let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
//       let imageName = imageURL.path!.lastPathComponent
//       let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as String
//       let localPath = documentDirectory.stringByAppendingPathComponent(imageName)

//       let image = info[UIImagePickerControllerOriginalImage] as UIImage
//       let data = UIImagePNGRepresentation(image)
//       data.writeToFile(localPath, atomically: true)

//       let imageData = NSData(contentsOfFile: localPath)!
//       let photoURL = NSURL(fileURLWithPath: localPath)
//       let imageWithData = UIImage(data: imageData)!
//        dismiss(animated: true)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        
    }
    
    private var imagePicker = UIImagePickerController()
    
    // MARK: Outlets
    
    private lazy var pickImagesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pick images", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.layer.cornerRadius = 15
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
