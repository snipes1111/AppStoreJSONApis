//
//  AppRowCell.swift
//  AppStoreJSONApis
//
//  Created by user on 07/03/2023.
//

import UIKit

class AppRowCell: UnderlineCellWithNoConstraint {
    
    let appIconImageView = UIImageView(cornerRadius: 12)
    let appNameLabel = UILabel(text: "App name", font: .systemFont(ofSize: 20))
    let companyNameLabel = UILabel(text: "Company name", font: .systemFont(ofSize: 12))
    private let getButton = UIButton(title: "GET")
    lazy var imageHeight = self.frame.height - 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        appIconImageView.constrainWidth(constant: imageHeight)
        appIconImageView.constrainHeight(constant: imageHeight)
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
        addSubview(overalStackView)
        overalStackView.fillSuperview()
        underlineView.anchor(top: nil, leading: companyNameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
