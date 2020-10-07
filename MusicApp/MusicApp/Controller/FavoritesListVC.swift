//
//  FavoritesListVC.swift
//  MusicApp
//
//  Created by Mondale on 9/16/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit
import Spartan
import Foundation


class FavoritesListVC: UIViewController {

    let tableView = UITableView()
    var favoritesList: [String] = UserDefaults.standard.stringArray(forKey: "favTracks") ?? [String]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewController()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print(favoritesList)
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
    
    private func configureViewController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        title = "Favorites"

    }
    


}
