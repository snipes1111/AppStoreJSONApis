//
//  TodayMultipleAppCell.swift
//  AppStoreJSONApis
//
//  Created by user on 21/03/2023.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
    
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            contentView.backgroundColor = todayItem.backGroundColor
        }
    }
    
    private var categoryLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 22))
    private var titleLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 28))
    
    let appCollectionViewController = TodayMultipleAppController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 12
        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel, titleLabel, appCollectionViewController.view], spacing: 8)
        contentView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
