//
//  AppController.swift
//  AppStoreJSONApis
//
//  Created by user on 07/03/2023.
//

import UIKit

class AppPageController: BaseSectionController {
    
    private let reuseIdentifier = "AppCell"
    private let headerId = "AppHeader"
    private let sectionSize: CGFloat = 300

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.register(AppCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(AppHeadeView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        fetchData()
        view.addSubview(activityIndicator)
        activityIndicator.fillSuperview()
    }
    
    private var appGroupResults = [AppResult]()
    private var appHeaderApps = [AppHeaderApps]()
    
    private func fetchData() {
        
        var group1: AppResult?
        var group2: AppResult?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchAppHeaderApps { headerApps, err in
            if let err = err {
                print("Failed to fetch header apps: ", err)
            }
            dispatchGroup.leave()
            print("Done with header apps")
            guard let headerApps = headerApps else { return }
            self.appHeaderApps = headerApps
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopFree(with: { appRes, err in
            dispatchGroup.leave()
            print("Done with top free apps")
            guard let appResult = appRes else { return }
            group1 = appResult
        })
        
        dispatchGroup.enter()
        Service.shared.fetchTopPaid(with: { appRes, err in
            if let err = err {
                print("Failed to fetch header apps: ", err)
            }
            dispatchGroup.leave()
            print("Done with top paid apps")
            guard let appResult = appRes else { return }
            group2 = appResult
        })
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicator.stopAnimating()
            print("Complited your dispatch tasks...")
            let groups = [group1, group2]
            groups.forEach { group in
                if let group = group {
                    self.appGroupResults.append(group)
                }
            }
            self.collectionView.reloadData()
        }
        
        
    }
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        appGroupResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppCell
        let appResult = appGroupResults[indexPath.item]
        cell.appSectionLabel.text = appResult.feed.title
        cell.horizontalViewController.appResult = appResult
        cell.horizontalViewController.didSelectHandler = { [weak self] feedResult in
            let controller = AppDetailController(appId: feedResult.id)
            controller.navigationItem.title = feedResult.name
            self?.navigationController?.pushViewController(controller, animated: true)
        }
        cell.horizontalViewController.collectionView.reloadData()
        return cell
    }
    
    
}


extension AppPageController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: sectionSize)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppHeadeView
        view.headerCollectionView.appGroup = appHeaderApps
        view.headerCollectionView.collectionView.reloadData()
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: view.frame.width, height: sectionSize)
    }
}
