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
        getUsersTopArtists()
        configureViewController()
        configureTableView()
    
    }
    
    
    
    private func configureViewController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        title = "Top 50"

    }
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100
        tableView.register(ArtistCell.self, forCellReuseIdentifier: "ArtistCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
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
                    self.tableView.reloadData()
                }
            }

    }
}

extension HomeVC: UITableViewDelegate {
    
    
}


extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! ArtistCell
        let artist = artistList[indexPath.row]
        let artistImageUrL = artist.images.first?.url
        
        cell.artistNameLabel.text = artist.name
        cell.downloadImage(from: artistImageUrL)
        
            
        return cell
    }
    
    
}
