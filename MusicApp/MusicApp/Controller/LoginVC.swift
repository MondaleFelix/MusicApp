//
//  LoginVC.swift
//  MusicApp
//
//  Created by Mondale on 9/11/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    let logoImageView = UIImageView()
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureLogoImageView()
        configureLoginButton()

    }

    private func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    
    private func configureLoginButton(){
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 10
        loginButton.setTitle("Log In", for: .normal)
        loginButton.backgroundColor = .systemGreen
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            loginButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func loginButtonPressed(){
        print("Pressed")
    }
}
