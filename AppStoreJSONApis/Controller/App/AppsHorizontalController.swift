//
//  AppsHorizontalController.swift
//  AppStoreJSONApis
//
//  Created by user on 07/03/2023.
//

import UIKit

class AppsHorizontalController: BaseSectionController {
    
    private let reuseIdentifier = "cellId"
    private let topBottomInsets: CGFloat = 12
    private let lineSpacing: CGFloat = 10
    
    var appResult: AppResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.scrollDirection = .horizontal
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppRowCell
        guard let app = appResult?.feed.results[indexPath.item] else { return UICollectionViewCell() }
        cell.companyNameLabel.text = app.artistName
        cell.appNameLabel.text = app.name
        cell.appIconImageView.sd_setImage(with: URL(string: app.artworkUrl100))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResult?.feed.results.count ?? 0
    }
    
    
    
}


extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let calculatedHeight: CGFloat = collectionView.frame.height - topBottomInsets * 2 - lineSpacing * 2
        
        return .init(width: collectionView.frame.width - 48, height: calculatedHeight / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: topBottomInsets, left: 16, bottom: topBottomInsets, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        lineSpacing
    }
}
