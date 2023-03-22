//
//  TodayMultipleAppController.swift
//  AppStoreJSONApis
//
//  Created by user on 22/03/2023.
//

import UIKit

class TodayMultipleAppController: BaseSectionController {
    
    private var linespacing: CGFloat = 8
    var appResults = [FeedResults]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: AppsHorizontalController.reuseIdentifier)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        min(4, appResults.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHorizontalController.reuseIdentifier, for: indexPath) as! AppRowCell
        cell.feedResult = appResults[indexPath.item]
        return cell
    }
    
}

extension TodayMultipleAppController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.height - 3 * linespacing
        return .init(width: view.frame.width, height: height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        linespacing
    }
    
}
