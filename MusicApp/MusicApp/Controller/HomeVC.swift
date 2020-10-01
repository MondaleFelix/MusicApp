//
//  HomeVC.swift
//  MusicApp
//
//  Created by Mondale on 9/16/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit
import Spartan

class HomeVC: UIViewController {

    let tableView = UITableView()
    var artistList: [Artist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        title = "Top 50"
        getUsersTopArtists()
        
    }
    
    
    
    private func configureViewController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
        
    }
    
    func getUsersTopArtists(){
        NetworkManager.fetchTopArtists() { (result) in
            
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let artists):
                    self.artistList = artists
                }
            }

    }
}
