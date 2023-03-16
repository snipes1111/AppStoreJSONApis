//
//  Extensions.swift
//  AppStoreJSONApis
//
//  Created by user on 07/03/2023.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont, numberOfLines: Int = 2) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(frame: .zero)
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
}

extension UIButton {
    
    convenience init(title: String) {
        self.init(type: .system)
        setTitle(title, for: .normal)
    }
    
}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        spacing = customSpacing
    }
}

extension Int {
    func makeShortDescrString() -> String {
        switch self {
        case let num where num < 1000:
            return "\(self)"
        case let num where num > 1000 && num < 1000000:
            return "\(self / 1000)K"
        default:
            return "\(self / 1000000)M"
        }
    }
}
