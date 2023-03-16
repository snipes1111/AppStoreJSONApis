//
//  UnderlinneCell.swift
//  AppStoreJSONApis
//
//  Created by user on 16/03/2023.
//

import UIKit

class UnderlineCell: UICollectionViewCell {
    let underlineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Set up views
        contentView.addSubview(underlineView)
        underlineView.constrainHeight(constant: 0.5)
        
        // Styling
        underlineView.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
