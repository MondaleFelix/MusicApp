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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTrackImage()
        view.backgroundColor = .systemGray
    }
    

    private func configureTrackImage(){
        view.addSubview(trackImageView)
        trackImageView.translatesAutoresizingMaskIntoConstraints = false
        trackImageView.image = trackImage

        
        NSLayoutConstraint.activate([
            trackImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            trackImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackImageView.heightAnchor.constraint(equalToConstant: 200),
            trackImageView.widthAnchor.constraint(equalToConstant: 200)
        
        
        ])
    }
}
