//
//  AppDetailController.swift
//  AppStoreJSONApis
//
//  Created by user on 13/03/2023.
//

import UIKit

class AppDetailController: BaseSectionController {
    
    var detailAppCellId = "detailAppCell"
    var screenshotCellId = "scrAppCell"
    var reviewCellId = "reviewCell"
    var app: Result?
    var review: ReviewsResult?
    
    var appId: String? {
        didSet {
            let urlStringApp = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            Service.shared.fetchGenericJSONData(urlString: urlStringApp) { (searchResult: SearchResult?, err) in
                
                if let err = err { print(("Error to fetch app details: "), err) }
                
                guard let searchResult = searchResult else { return }
                self.app = searchResult.results.first
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
            let urlStringReview = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId ?? "")/sortby=mostrecent/json?l=en&cc=us"
            Service.shared.fetchGenericJSONData(urlString: urlStringReview) { (searchResult: ReviewsResult?, err) in
                if let err = err { print(("Error to fetch app details: "), err) }
                
                guard let searchResult = searchResult else { return }
                self.review = searchResult
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        collectionView.register(DetailAppCell.self, forCellWithReuseIdentifier: detailAppCellId)
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: screenshotCellId)
        collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailAppCellId, for: indexPath) as! DetailAppCell
            cell.app = app
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotCellId, for: indexPath) as! ScreenshotCell
            cell.scrHorizontalCollection.app = app
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewRowCell
            cell.reviewController.review = review
            return cell
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
}

extension AppDetailController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 280
        switch indexPath.item {
        case 0:
            // calculate necessary size for cells
            let dummyCell = DetailAppCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.app = app
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            height = estimatedSize.height
        case 1:
            height = 500
        default:
            height = 280
        }
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 20, right: 0)
    }
    
}

