//
//  ArtistCell.swift
//  MusicApp
//
//  Created by Mondale on 9/30/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ArtistCell: UITableViewCell {

    let artistImage = UIImageView()
    let artistNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureArtistImage()
        configureNameLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureArtistImage(){
        contentView.addSubview(artistImage)
        artistImage.translatesAutoresizingMaskIntoConstraints = false
        artistImage.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            artistImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            artistImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            artistImage.heightAnchor.constraint(equalToConstant: 80),
            artistImage.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 3)
        ])
        
    }
    
    private func configureNameLabel(){
        contentView.addSubview(artistNameLabel)
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            artistNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            artistNameLabel.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 20),
            artistNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
        
        ])
    }
    
    func downloadImage(from urlString: String?){

        guard let urlString = urlString else { return }


//        let cache = NetworkManager.shared.cache
//        let cacheKey = NSString(string: urlString)
//
//        // Sets the Cell image if found in cache
//        if let image = cache.object(forKey: cacheKey) {
//            self.articleImageView?.image = image
//            return
//        }

        
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in

            guard let self = self else { return }


            if let _ = error { return }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }

            guard let image = UIImage(data: data) else { return }

            // Adds the image to cache
//            cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.artistImage.image = image
            }

        }
        task.resume()
    }

    
}
