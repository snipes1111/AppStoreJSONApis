//
//  ScreenshotController.swift
//  AppStoreJSONApis
//
//  Created by user on 14/03/2023.
//

import UIKit

class ScreenshotController: HorizontalSnappingController {
    
    private let cellId = "scrCell"
    
    var app: Result? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    class scrCell: UICollectionViewCell {
        
        let imageView = UIImageView(cornerRadius: 12)
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(imageView)
            imageView.fillSuperview()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(scrCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        app?.screenshotUrls.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! scrCell
        let urlString = app?.screenshotUrls[indexPath.item]
        cell.imageView.sd_setImage(with: URL(string: urlString ?? ""))
        return cell
    }
    
    
}

extension ScreenshotController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 250, height: view.frame.height)
    }
    
}
