//
//  AppRowCell.swift
//  AppStoreJSONApis
//
//  Created by user on 07/03/2023.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    let appIconImageView = UIImageView(cornerRadius: 12)
    let appNameLabel = UILabel(text: "App name", font: .systemFont(ofSize: 20))
    let companyNameLabel = UILabel(text: "Company name", font: .systemFont(ofSize: 12))
    let getButton = UIButton(title: "GET")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        appIconImageView.backgroundColor = .red
        appIconImageView.constrainWidth(constant: 64)
        appIconImageView.constrainHeight(constant: 64)
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.layer.cornerRadius = 16
        
        let overalStackView = UIStackView(arrangedSubviews: [appIconImageView,
                                                             VerticalStackView(arrangedSubviews: [appNameLabel, companyNameLabel], spacing: 4),
                                                             getButton])
        overalStackView.spacing = 12
        overalStackView.alignment = .center
        self.addSubview(overalStackView)
        overalStackView.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
