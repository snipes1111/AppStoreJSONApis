//
//  SearchResultCell.swift
//  AppStoreJSONApis
//
//  Created by user on 03/03/2023.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App name"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Videos"
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "9.27M"
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var screenshotImageViewOne = self.getImageView()
    lazy var screenshotImageViewTwo = self.getImageView()
    lazy var screenshotImageViewThree = self.getImageView()
    
    
    private func getImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let topInfoStackView = UIStackView(arrangedSubviews: [appIconImageView,
                                                              VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingLabel]),
                                                              getButton])
        topInfoStackView.alignment = .center
        topInfoStackView.spacing = 12
        
        let screenShotStackView = UIStackView(arrangedSubviews: [screenshotImageViewOne, screenshotImageViewTwo, screenshotImageViewThree])
        screenShotStackView.spacing = 12
        screenShotStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(arrangedSubviews: [topInfoStackView, screenShotStackView], spacing: 16)
        
        contentView.addSubview(overallStackView)
        // setup constraints by UIView Helper Extension
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
