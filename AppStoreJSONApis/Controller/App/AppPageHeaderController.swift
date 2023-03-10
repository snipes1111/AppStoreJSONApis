//
//  AppPageHeaderController.swift
//  AppStoreJSONApis
//
//  Created by user on 09/03/2023.
//

import UIKit

class AppPageHeaderController: BaseSectionController {
    
    private let reuseIdentifier = "headerCell"
    
    var appGroup = [AppHeaderApps]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.scrollDirection = .horizontal
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppsHeaderCell
        let app = appGroup[indexPath.item]
        cell.companyLabel.text = app.name
        cell.titleLabel.text = app.tagline
        cell.titleImageView.sd_setImage(with: URL(string: app.imageUrl))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        appGroup.count
    }
    
}

extension AppPageHeaderController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}
