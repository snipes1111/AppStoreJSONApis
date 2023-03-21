//
//  AppFullScreenHeaderCell.swift
//  AppStoreJSONApis
//
//  Created by user on 20/03/2023.
//

import UIKit

class AppFullScreenHeaderCell: UITableViewCell {
    
    let todayCell = TodayCell()
    
    let closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark.circle")
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        todayCell.contentView.addSubview(closeButton)
        closeButton.anchor(top: todayCell.contentView.topAnchor, leading: nil, bottom: nil, trailing: todayCell.contentView.trailingAnchor, padding: .init(top: 48, left: 0, bottom: 0, right: 20), size: .init(width: 38, height: 38))
        contentView.addSubview(todayCell.contentView)
        todayCell.contentView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
