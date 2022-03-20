//
//  RootViewController.swift
//  TakeAndSendPhotos
//
//  Created by mac on 10.03.2022.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: UI
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.text = "Please, enter your login and password"
        label.frame = CGRect(x: 300, y: 300, width: 100, height: 20)
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.placeholder = "login"
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.placeholder = "password"
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(onLogin), for: .touchUpInside)
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    // MARK: Injections
    var presenter: RootPresenterInput!
    var configurator: RootConfigurable!

    // MARK: View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.widthAnchor.constraint(equalToConstant: 300),
            textLabel.heightAnchor.constraint(equalToConstant: 50),
            textLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 2),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.widthAnchor.constraint(equalToConstant: 100),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordTextField.widthAnchor.constraint(equalToConstant: 100),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.widthAnchor.constraint(equalToConstant: 120),
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
        textLabel.text = text
    }
}

extension RootViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(RootViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
