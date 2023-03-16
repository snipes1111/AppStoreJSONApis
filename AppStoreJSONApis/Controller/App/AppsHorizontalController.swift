//
//  AppsHorizontalController.swift
//  AppStoreJSONApis
//
//  Created by user on 07/03/2023.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController {
    
    private let reuseIdentifier = "cellId"
    private let lineSpacing: CGFloat = 12
    
    var appResult: AppResult?
    var didSelectHandler: ((FeedResults?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appResult?.feed.results[indexPath.item] {
            didSelectHandler?(app)
        }
        if let item = collectionView.cellForItem(at: indexPath) {
            print(item.frame.maxY, collectionView.frame.maxY)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppRowCell
        guard let app = appResult?.feed.results[indexPath.item] else { return UICollectionViewCell() }
        cell.companyNameLabel.text = app.artistName
        cell.appNameLabel.text = app.name
        cell.appIconImageView.sd_setImage(with: URL(string: app.artworkUrl100))
        
        if  cell.frame.maxY - collectionView.frame.maxY >= 0  {
            cell.underlineView.isHidden = true
        }
        
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
