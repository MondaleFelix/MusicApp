//
//  ArtistTracksVC.swift
//  MusicApp
//
//  Created by Mondale on 10/1/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit
import Spartan

class ArtistTracksVC: UIViewController {

    let tableView = UITableView()
    var artistTracksList: [Track] = []
    var artist: Artist! = nil
    lazy var artistID = self.artist.id as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArtistTopTracks()
        configureViewController()
        configureTableView()
    
    }
    
    
    
    private func configureViewController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        title = artist.name

    }
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100
        tableView.register(ArtistCell.self, forCellReuseIdentifier: "TrackCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
        
    }

    func getArtistTopTracks(){
        NetworkManager.fetchArtistTopTracks(artistId: artistID) { (result) in
            
            switch result{
            case .failure(let error):
                print(error)
                
            case .success(let tracks):
                print(tracks)
                self.artistTracksList = tracks
                self.tableView.reloadData()
            }
            
        }
        
        

    }
}

extension ArtistTracksVC: UITableViewDelegate {
    
    
}


extension ArtistTracksVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistTracksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell") as! ArtistCell
        let track = artistTracksList[indexPath.row]
        cell.artistNameLabel.text = track.name
        
        let imageUrl = track.album.images.first?.url
        cell.downloadImage(from: imageUrl)
        return cell
        
    }
    
    
}
