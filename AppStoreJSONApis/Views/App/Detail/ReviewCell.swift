//
//  ReviewCell.swift
//  AppStoreJSONApis
//
//  Created by user on 15/03/2023.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 16))
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    let reviewBodyLabel = UILabel(text: "Review body",
                                  font: .systemFont(ofSize: 16),
                                  numberOfLines: 5)
    let starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        
        (0..<5).forEach { _ in
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "star.fill")
            imageView.tintColor = #colorLiteral(red: 0.9427429438, green: 0.5066766143, blue: 0.1150025204, alpha: 1)
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubviews.append(imageView)
        }
        arrangedSubviews.append(UIView())
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = #colorLiteral(red: 0.9464729428, green: 0.9405035377, blue: 0.9712290168, alpha: 1)
        
        authorLabel.setContentHuggingPriority(.init(rawValue: 1000), for: .horizontal)
        
        let stackView = VerticalStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [titleLabel, authorLabel], customSpacing: 8),
                                                             starsStackView,
                                                             reviewBodyLabel],
                                          spacing: 12)
        contentView.addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
