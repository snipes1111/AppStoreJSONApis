//
//  AppsHeaderCell.swift
//  AppStoreJSONApis
//
//  Created by user on 09/03/2023.
//

import UIKit

class AppsHeaderCell: UnderlineCell {
    
    let companyLabel = UILabel(text: "Facebbook", font: .boldSystemFont(ofSize: 12))
    let titleLabel = UILabel(text: "Keeping up with friends is faster then ever", font: .systemFont(ofSize: 24))
    let titleImageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        companyLabel.textColor = .blue
        titleLabel.numberOfLines = 0

        let stackView = VerticalStackView(arrangedSubviews: [companyLabel, titleLabel, titleImageView], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 16, right: 0))
        
        underlineView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
