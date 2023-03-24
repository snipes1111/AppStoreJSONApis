//
//  TrackCell.swift
//  AppStoreJSONApis
//
//  Created by user on 24/03/2023.
//

import UIKit

class TrackCell: UICollectionViewCell {
    
    var currentTrack: MusicResult? {
        didSet {
            trackNameLabel.text = currentTrack?.trackName
            subtitleLabel.text = "\(currentTrack?.artistName ?? "") * \(currentTrack?.collectionName ?? "")"
            albumImageView.sd_setImage(with: URL(string: currentTrack?.artworkUrl100 ?? ""))
        }
    }
    
    let albumImageView: UIImageView = {
       let imageView = UIImageView(cornerRadius: 12)
        imageView.image = #imageLiteral(resourceName: "garden")
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        return imageView
    }()
    
    let trackNameLabel: UILabel = {
        let label = UILabel(text: "Track Name", font: .boldSystemFont(ofSize: 18))
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel(text: "Subtitle text", font: .systemFont(ofSize: 14))
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [albumImageView,
                                                      VerticalStackView(arrangedSubviews: [trackNameLabel, subtitleLabel], spacing: 4),
                                                      ], customSpacing: 12)
        stackView.alignment = .center
        contentView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 12, bottom: 0, right: 12))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
