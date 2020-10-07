//
//  TrackPlayer.swift
//  MusicApp
//
//  Created by Mondale on 10/1/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit
import Spartan
import Foundation
import AVFoundation

class TrackPlayerVC: UIViewController {

    let trackImageView = UIImageView()
    var track: Track!
    var player: AVPlayer?
    let userDefaults = UserDefaults.standard
    
    var trackImage: UIImage!
    let songNameLabel = UILabel()
    let albumNameLabel = UILabel()
    let playbackSlider = UISlider()
    
    let playButton = UIButton()
    let favoriteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTrackImage()
        configureNameLabels()
        configurePlaybackSlider()
        configurePlayButton()
        configureFavoriteButton()
        retrieveAudioPreview()
        view.backgroundColor = .black
    }
    

    private func configureTrackImage(){
        view.addSubview(trackImageView)
        trackImageView.translatesAutoresizingMaskIntoConstraints = false
        trackImageView.image = trackImage

        
        NSLayoutConstraint.activate([
            trackImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            trackImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackImageView.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.80),
            trackImageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.80)
        
        ])
    }
    
    
    private func configureNameLabels(){
        view.addSubview(songNameLabel)
        view.addSubview(albumNameLabel)
        
        songNameLabel.text = track.name
        albumNameLabel.text = track.album.name
        
        songNameLabel.textColor = .white
    
        albumNameLabel.textColor = .white
        
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            songNameLabel.topAnchor.constraint(equalTo: trackImageView.bottomAnchor, constant: 25),
            songNameLabel.leadingAnchor.constraint(equalTo: trackImageView.leadingAnchor),
            songNameLabel.trailingAnchor.constraint(equalTo: trackImageView.trailingAnchor),
            songNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            albumNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 10),
            albumNameLabel.leadingAnchor.constraint(equalTo: trackImageView.leadingAnchor),
            albumNameLabel.trailingAnchor.constraint(equalTo: trackImageView.trailingAnchor),
            albumNameLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
    
    
    private func configurePlaybackSlider(){
        view.addSubview(playbackSlider)
        playbackSlider.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            playbackSlider.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 10),
            playbackSlider.leadingAnchor.constraint(equalTo: trackImageView.leadingAnchor),
            playbackSlider.trailingAnchor.constraint(equalTo: trackImageView.trailingAnchor),
            playbackSlider.heightAnchor.constraint(equalToConstant: 20)
        
        ])
    }
    
    private func configurePlayButton(){
        view.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        playButton.backgroundColor = .red
        playButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: playbackSlider.bottomAnchor, constant: 20),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.widthAnchor.constraint(equalToConstant: 50),
        
        ])
    }
    
    
    @objc func playButtonPressed(){
        player?.play()
    }
    
    
    private func configureFavoriteButton(){
        view.addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        favoriteButton.backgroundColor = .blue
        favoriteButton.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: playbackSlider.bottomAnchor, constant: 20),
            favoriteButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
        
        ])
    }
    
    
    @objc func favoriteButtonPressed(){
        guard var favoritesList = userDefaults.stringArray(forKey: "favTracks") else {
            return
        }
        favoritesList.append(track.id as! String)
        userDefaults.set(favoritesList, forKey: "favTracks")
        print(favoritesList)
        print("set track id")
    }
    
    
    private func retrieveAudioPreview(){
        let urlString = track.previewUrl
        guard let url = URL.init(string: urlString!) else { return }
        
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        
    }
}
