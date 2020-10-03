//
//  TrackPlayer.swift
//  MusicApp
//
//  Created by Mondale on 10/1/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit
import Spartan

class TrackPlayerVC: UIViewController {

    let trackImageView = UIImageView()
    var track: Track!
    
    var trackImage: UIImage!
    let songNameLabel = UILabel()
    let albumNameLabel = UILabel()
    let playbackSlider = UISlider()
    
    let minTimeLabel = UILabel()
    let maxTimeLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTrackImage()
        configureNameLabels()
        configurePlaybackSlider()
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
    
    
    private func configureTimeLabels(){
        view.addSubview(minTimeLabel)
        view.addSubview(maxTimeLabel)
        
        NSLayoutConstraint.activate([
            minTimeLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 10),
            minTimeLabel.leadingAnchor.constraint(equalTo: playbackSlider.leadingAnchor),
            minTimeLabel.widthAnchor.constraint(equalToConstant: <#T##CGFloat#>)
        
        
        ])
    }
}
