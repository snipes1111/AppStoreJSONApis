//
//  TodayCell.swift
//  AppStoreJSONApis
//
//  Created by user on 17/03/2023.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "garden")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .white
        contentView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 250, height: 250))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
