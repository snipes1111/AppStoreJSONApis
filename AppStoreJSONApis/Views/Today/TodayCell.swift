//
//  TodayCell.swift
//  AppStoreJSONApis
//
//  Created by user on 17/03/2023.
//

import UIKit

class TodayCell: BaseTodayCell {
    
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            descriptionLabel.text = todayItem.descriptionText
            imageView.image = todayItem.image
            contentView.backgroundColor = todayItem.backGroundColor
        }
    }
    
    var topConstraint: NSLayoutConstraint?
    
    private var categoryLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 24))
    private var titleLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 28))
    private var descriptionLabel = UILabel(text: "", font: .systemFont(ofSize: 18), numberOfLines: 0)
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "garden")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        
        let view = UIView()
        view.clipsToBounds = true
        view.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 200, height: 200))
        
        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel, titleLabel, view, descriptionLabel], spacing: 8)
        contentView.addSubview(stackView)
        stackView.anchor(top: nil, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        topConstraint = stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        topConstraint?.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
