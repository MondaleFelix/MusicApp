//
//  TrackPlayer.swift
//  MusicApp
//
//  Created by Mondale on 10/1/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit
import Spartan
import AVFoundation

class TrackPlayerVC: UIViewController {

    let trackImageView = UIImageView()
    var track: Track!
    var player: AVPlayer?
    
    var trackImage: UIImage!
    let songNameLabel = UILabel()
    let albumNameLabel = UILabel()
    let playbackSlider = UISlider()
    
    let playButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTrackImage()
        configureNameLabels()
        configurePlaybackSlider()
        configurePlayButton()
        view.backgroundColor = .systemGray
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
        
        let urlString = track.previewUrl
        guard let url = URL.init(string: urlString!)
            else {
               
                return
        }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
        
        
    }
    
}
