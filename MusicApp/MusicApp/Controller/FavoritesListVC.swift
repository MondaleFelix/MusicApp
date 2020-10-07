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
    
    var trackList:[Track] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersFavoriteTracks()
        configureTableView()
        configureViewController()
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArtistCell.self, forCellReuseIdentifier: "TrackCell")
        
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
    

    private func getUsersFavoriteTracks(){
        NetworkManager.fetchFavoritesTracks(ids: favoritesList) { (result) in
            
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let tracks):
                    self.trackList  = tracks
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

                }
            }

    }

}

extension FavoritesListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell") as! ArtistCell
        let track = trackList[indexPath.row]
        cell.artistNameLabel.text = track.name
        
        let imageUrl = track.album.images.first?.url
        cell.downloadImage(from: imageUrl)
        return cell
    }
    
    
}


extension FavoritesListVC: UITableViewDelegate {
    
}
