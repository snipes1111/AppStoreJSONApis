//
//  AppCell.swift
//  AppStoreJSONApis
//
//  Created by user on 07/03/2023.
//

import UIKit

class AppCell: UnderlineCell {
    
    let appSectionLabel = UILabel(text: "App section", font: .boldSystemFont(ofSize: 23))
    
    let horizontalViewController = AppsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(appSectionLabel)
        appSectionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 0))
        contentView.addSubview(horizontalViewController.view)
        horizontalViewController.view.anchor(top: appSectionLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 4, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
