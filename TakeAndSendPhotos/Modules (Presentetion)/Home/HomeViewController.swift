//
//  HomeViewController.swift
//  TakeAndSendPhotos
//
//  Created by mac on 06.03.2022.
//

import UIKit

class HomeViewController: UIViewController {
//    загрузить фото из ленты в UITableView, найти шаблонное решение кодом
    var tableView: UITableView!
    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeConfiguration.build(vc: self)
        
        presenter?.onViewDidLOad()
    }
}
