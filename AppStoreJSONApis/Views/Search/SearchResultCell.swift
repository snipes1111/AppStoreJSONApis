//
//  SearchResultCell.swift
//  AppStoreJSONApis
//
//  Created by user on 03/03/2023.
//

import UIKit

class SearchResultCell: UnderlineCell {
    
    var result: Result! {
        didSet {
            categoryLabel.text = result.primaryGenreName
            nameLabel.text = result.trackName
            ratingLabel.text = result.userRatingCount?.makeShortDescrString() ?? "0"
            
            // import images
            let url = URL(string: result.artworkUrl100)
            appIconImageView.sd_setImage(with: url)
            screenshotImageViewOne.sd_setImage(with: URL(string: result.screenshotUrls[0]))
            if result.screenshotUrls.count > 1 {
                screenshotImageViewTwo.sd_setImage(with: URL(string: result.screenshotUrls[1]))
            }
            if result.screenshotUrls.count > 2 {
                screenshotImageViewThree.sd_setImage(with: URL(string: result.screenshotUrls[2]))
            }
        }
    }
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
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
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.6002627611, green: 0.5721129775, blue: 0.5374191403, alpha: 1)
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var screenshotImageViewOne = self.getImageView()
    lazy var screenshotImageViewTwo = self.getImageView()
    lazy var screenshotImageViewThree = self.getImageView()
    
    
    private func getImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
        
        underlineView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
