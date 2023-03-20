//
//  AppDescriptionCell.swift
//  AppStoreJSONApis
//
//  Created by user on 20/03/2023.
//

import UIKit

class AppDescriptionCell: UITableViewCell {
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Great games", attributes: [.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: " are all about the details, from subtle visual effects to imaginative art styles. In these titles, you're sure to find something to marvel at, whether you're into fantasy worlds or neon-soaked dartboards.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: """
                                                 
                                                 
                                                 Heroic adventure
                                                 """,
                                                 attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: """
                                                 
                                                 Battle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.
                                                 """,
                                                 attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: """
                                                 
                                                 
                                                 Heroic adventure
                                                 """,
                                                 attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: """
                                                 
                                                 Battle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.
                                                 """,
                                                 attributes: [.foregroundColor: UIColor.gray]))
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.attributedText = attributedText
        label.numberOfLines = 0
        
       return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(descriptionLabel)
        descriptionLabel.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
