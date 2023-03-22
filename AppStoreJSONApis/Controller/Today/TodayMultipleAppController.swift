//
//  TodayMultipleAppController.swift
//  AppStoreJSONApis
//
//  Created by user on 22/03/2023.
//

import UIKit

enum Mode {
    case fullScreen, compact
}

class TodayMultipleAppController: BaseSectionController {
    
    private var mode: Mode
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private var linespacing: CGFloat = 8
    private var sideInset: CGFloat = 20
    
    var appResults = [FeedResults]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: AppsHorizontalController.reuseIdentifier)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mode == .compact ? min(4, appResults.count) : appResults.count
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
        return mode == .compact ? .init(width: view.frame.width, height: height / 4) : .init(width: view.frame.width - sideInset * 2, height: 74)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        linespacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  mode == .fullScreen ? .init(top: 12, left: sideInset, bottom: 12, right: sideInset) : .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
