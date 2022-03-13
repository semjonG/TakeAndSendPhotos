//
//  RootViewController.swift
//  TakeAndSendPhotos
//
//  Created by mac on 10.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: UI
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.placeholder = "login"
        
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.placeholder = "password"
        
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(onLogin), for: .touchUpInside)
        
        return button
    }()
    
    var label = UILabel()
    
    
    // MARK: Injections
    var presenter: RootPresenterInput!
    var configurator: RootConfigurable!

    // MARK: View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please, enter your login and password"
        
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            emailTextField.widthAnchor.constraint(equalToConstant: 100),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordTextField.widthAnchor.constraint(equalToConstant: 100),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.widthAnchor.constraint(equalToConstant: 100),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        configurator = RootConfigurator()
        configurator.configure(viewController: self)
        presenter.viewDidLoad()
        
    }

    @objc
    func onLogin() {
        presenter.onLogin(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
}

// MARK: - RootPresenterOutput
extension RootViewController: RootPresenterOutput {
    func showInfoLabel(text: String) {
        label.text = text
    }
    

}
