//
//  ReviewRowCell.swift
//  AppStoreJSONApis
//
//  Created by user on 15/03/2023.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    
    private let reviewAndRatingsLabel = UILabel(text: "Review & Ratings", font: .boldSystemFont(ofSize: 23))
    let reviewController = ReviewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(reviewAndRatingsLabel)
        contentView.addSubview(reviewController.view)
        reviewAndRatingsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        reviewController.view.anchor(top: reviewAndRatingsLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
