//
//  AppController.swift
//  AppStoreJSONApis
//
//  Created by user on 07/03/2023.
//

import UIKit

private let reuseIdentifier = "AppCell"
private let headerId = "AppHeader"
private let sectionSize: CGFloat = 300

class AppPageController: BaseSectionController {
    
    private var topFreeApps: AppResult?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.register(AppCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(AppHeadeView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        Service.shared.fetchGames { appRes, err in
            
            if let err = err {
                print("Failed to fetch app: ", err)
            }
            
            guard let appResult = appRes else { return }
            self.topFreeApps = appResult
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppCell
        cell.appSectionLabel.text = topFreeApps?.feed.title ?? ""
        cell.horizontalViewController.appResult = topFreeApps
        cell.horizontalViewController.collectionView.reloadData()
        return cell
    }


}


extension AppPageController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: sectionSize)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: view.frame.width, height: sectionSize)
    }
}
