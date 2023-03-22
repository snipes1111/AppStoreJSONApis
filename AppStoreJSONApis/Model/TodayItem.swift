//
//  TodayItem.swift
//  AppStoreJSONApis
//
//  Created by user on 21/03/2023.
//

import UIKit

struct TodayItem {
    let category, title, descriptionText: String
    let image: UIImage
    let backGroundColor: UIColor
    
    let cellType: CellType
    
    let feedResult: [FeedResults]
    
    enum CellType: String {
        case single, multiple
    }

    
}

