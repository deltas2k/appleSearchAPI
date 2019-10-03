//
//  ResultTableViewCell.swift
//  AppleSearch
//
//  Created by Matthew O'Connor on 10/3/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var albumImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var musicItem: MusicSearchResult? {
        didSet {
            guard let item = musicItem else {return}
            titleLabel.text = item.trackName
            descriptionLabel.text = item.artistName
            albumImageView.image = nil
            
            searchResultController.getMusicImageFor(item: item) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.albumImageView.image = image
                    }
                } else {
                    print("Image was nil")
                }
            }
        }
    }
    var appItem: AppSearchResult? {
    didSet {
        guard let item = appItem else {return}
        titleLabel.text = item.trackName
        descriptionLabel.text = item.description
        albumImageView.image = nil
        searchResultController.getAppImageFor(item: item) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                    self.albumImageView.image = image
                    } }else {
                    print("image was nil")
                }
            }
        }
    }

}
