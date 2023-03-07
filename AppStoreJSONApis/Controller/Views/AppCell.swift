//
//  AppCell.swift
//  AppStoreJSONApis
//
//  Created by user on 07/03/2023.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
    
}

class AppCell: UICollectionViewCell {
    
    let appSectionLabel = UILabel(text: "App section", font: .boldSystemFont(ofSize: 23))
    
    let horizontalViewController = AppsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        self.contentView.addSubview(appSectionLabel)
        appSectionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        self.contentView.addSubview(horizontalViewController.view)
        horizontalViewController.view.anchor(top: appSectionLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
