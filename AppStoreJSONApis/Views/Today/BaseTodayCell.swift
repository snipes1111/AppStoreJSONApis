//
//  BaseTodayCell.swift
//  AppStoreJSONApis
//
//  Created by user on 21/03/2023.
//

import UIKit

class BaseTodayCell: UICollectionViewCell {
    var todayItem: TodayItem!
    
    override var isHighlighted: Bool {
        didSet {
            var transform: CGAffineTransform = .identity
            if isHighlighted {
                transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1) {
                self.transform = transform
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.shadowOffset = .init(width: 0, height: 10)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
