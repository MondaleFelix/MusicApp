//
//  LoginVC.swift
//  MusicApp
//
//  Created by Mondale on 9/11/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit
import AuthenticationServices
import CryptoKit

class LoginVC: UIViewController,ASWebAuthenticationPresentationContextProviding {

    let logoImageView = UIImageView()
    let loginButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureLogoImageView()
        configureLoginButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = true
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
        getAuthentication()
    }
    
    
    func getAuthentication(){

            let scopeAsString = NetworkManager.stringScopes.joined(separator: "%20")

            let url = URL(string: "https://accounts.spotify.com/authorize?client_id=\(NetworkManager.clientId)&response_type=code&redirect_uri=\(NetworkManager.redirectURI)&scope=\(scopeAsString)")!

            let scheme = "auth"

            let session = ASWebAuthenticationSession(url: url, callbackURLScheme: scheme)

            { callbackURL, error in

                guard error == nil, let callbackURL = callbackURL else { return }

                let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
                guard let requestToken = queryItems?.first(where: { $0.name == "code" })?.value else { return }
                print("Code \(requestToken)")

                NetworkManager.authorizationCode = requestToken
                NetworkManager.fetchAccessToken { (result) in

                    switch result {
                    
                    case .failure(let error):
                        DispatchQueue.main.async {
                            print(error.localizedDescription)
                        }
                        
                    case .success(let spotifyAuth):
                        print("We got Access token \(spotifyAuth.accessToken)")
                        NetworkManager.fetchUser(accessToken: spotifyAuth.accessToken) { (result) in
                            switch result{
                            case .failure(let error):
                                print(error)
                            case .success(let user):
                                print(user)
                                self.navigationController?.pushViewController(HomeVC(), animated: true)
                            }
                        }
                    }
                }

            }

        session.presentationContextProvider = self
        session.start()
}


    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }


}
