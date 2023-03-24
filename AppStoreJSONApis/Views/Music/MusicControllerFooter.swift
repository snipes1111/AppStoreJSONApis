//
//  MusicControllerFooter.swift
//  AppStoreJSONApis
//
//  Created by user on 24/03/2023.
//

import UIKit

class MusicControllerFooter: UICollectionReusableView {
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        view.color = .darkGray
        view.hidesWhenStopped = true
        return view
    }()
    
    let loadingTextLabel = UILabel(text: "Loading more...", font: .boldSystemFont(ofSize: 12))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadingTextLabel.textAlignment = .center
        let stackView = VerticalStackView(arrangedSubviews: [activityIndicator, loadingTextLabel], spacing: 8)
        
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 150, height: 70))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
