//
//  AppsHorizontalController.swift
//  AppStoreJSONApis
//
//  Created by user on 07/03/2023.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController {
    
    static let reuseIdentifier = "cellId"
    private let lineSpacing: CGFloat = 12
    
    var appResult: AppResult?
    var didSelectHandler: ((FeedResults) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: AppsHorizontalController.reuseIdentifier)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appResult?.feed.results[indexPath.item] {
            didSelectHandler?(app)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHorizontalController.reuseIdentifier, for: indexPath) as! AppRowCell
        guard let app = appResult?.feed.results[indexPath.item] else { return UICollectionViewCell() }
        cell.feedResult = app
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResult?.feed.results.count ?? 0
    }
    
    
    
}


extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let calculatedHeight: CGFloat = collectionView.frame.height - lineSpacing * 2
        
        return .init(width: collectionView.frame.width - 48, height: calculatedHeight / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        lineSpacing
    }
}

extension AppsHorizontalController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
