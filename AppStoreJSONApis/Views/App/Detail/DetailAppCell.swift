//
//  DetailAppCell.swift
//  AppStoreJSONApis
//
//  Created by user on 13/03/2023.
//

import UIKit

class DetailAppCell: UnderlineCell {
    
    var app: Result? {
        didSet {
            appNameLabel.text = app?.trackName
            whatsNewTextLabel.text = app?.releaseNotes
            priceButton.setTitle(app?.formattedPrice, for: .normal)
            appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
        }
    }
    
    let appIconImageView = UIImageView(cornerRadius: 12)
    let appNameLabel = UILabel(text: "My apps name", font: .boldSystemFont(ofSize: 23), numberOfLines: 2)
    let priceButton = UIButton(title: "4.99$")
    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 23))
    let whatsNewTextLabel = UILabel(text: "Release notes", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        priceButton.backgroundColor = #colorLiteral(red: 0.2020222247, green: 0.480992198, blue: 0.9323017001, alpha: 1)
        priceButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        priceButton.layer.cornerRadius = 16
        priceButton.setTitleColor(.white, for: .normal)
        priceButton.constrainWidth(constant: 80)
    
        appIconImageView.constrainHeight(constant: 140)
        appIconImageView.constrainWidth(constant: 140)
        
        
        let labelStackView = VerticalStackView(arrangedSubviews: [appNameLabel, UIStackView(arrangedSubviews: [priceButton, UIView()]), UIView()], spacing: 12)
        let middleStackView = UIStackView(arrangedSubviews: [appIconImageView, labelStackView], customSpacing: 12)
        let overallStackView = VerticalStackView(arrangedSubviews: [middleStackView, whatsNewLabel, whatsNewTextLabel], spacing: 12)
        
        contentView.addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


