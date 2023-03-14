//
//  ScreenshotsAppCell.swift
//  AppStoreJSONApis
//
//  Created by user on 14/03/2023.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
    
    let scrHorizontalCollection = ScreenshotController()
    private let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 23))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(previewLabel)
        contentView.addSubview(scrHorizontalCollection.view)
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        scrHorizontalCollection.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
