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
        contentView.addSubview(underlineView)
        underlineView.constrainHeight(constant: 0.5)
        underlineView.backgroundColor = .lightGray
        underlineView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class UnderlineCellWithNoConstraint: UICollectionViewCell {
    let underlineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(underlineView)
        underlineView.constrainHeight(constant: 0.5)
        underlineView.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
