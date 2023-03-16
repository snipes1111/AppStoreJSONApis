//
//  ReviewController.swift
//  AppStoreJSONApis
//
//  Created by user on 15/03/2023.
//

import UIKit

class ReviewController: HorizontalSnappingController {
    
    var review: ReviewsResult? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        review?.feed.entry.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReviewCell
        let rev = review?.feed.entry[indexPath.item]
        cell.authorLabel.text = rev?.author.name.label
        cell.titleLabel.text = rev?.title.label
        cell.reviewBodyLabel.text = rev?.content.label
        
        for (index, view) in cell.starsStackView.arrangedSubviews.enumerated() {
            guard let rating = rev?.rating.label else { break }
            guard let ratingInt = Int(rating) else { break }
            view.alpha = ratingInt > index ? 1 : 0
        }
        
        return cell
    }
    
}

extension ReviewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width - 48, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
}
