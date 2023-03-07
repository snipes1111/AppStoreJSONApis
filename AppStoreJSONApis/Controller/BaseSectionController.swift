//
//  BaseSectionController.swift
//  AppStoreJSONApis
//
//  Created by user on 07/03/2023.
//

import UIKit

class BaseSectionController: UICollectionViewController {

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
