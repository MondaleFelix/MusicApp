//
//  HomeVC.swift
//  MusicApp
//
//  Created by Mondale on 9/16/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        
    }
    
    
    private func configureViewController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground    }
    
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
}
