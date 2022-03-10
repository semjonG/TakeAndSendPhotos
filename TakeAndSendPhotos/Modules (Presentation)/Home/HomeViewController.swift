//
//  HomeViewController.swift
//  TakeAndSendPhotos
//
//  Created by mac on 06.03.2022.
//

import UIKit

class HomeViewController: UIViewController {

    var tableView: UITableView!
    var presenter: HomePresenter?
    
    //    загрузить фото из ленты в UITableView
    @IBOutlet weak var img: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func pickImagePressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        HomeConfiguration.configurate(vc: self)
        
        presenter?.onViewDidLOad()
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            img.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
