//
//  AppPageHeaderView.swift
//  AppStoreJSONApis
//
//  Created by user on 09/03/2023.
//

import UIKit

class AppHeadeView: UICollectionReusableView {
    
    private let headerCollectionView = AppPageHeaderController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerCollectionView.view)
        headerCollectionView.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
