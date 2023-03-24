//
//  AppFullScreenController.swift
//  AppStoreJSONApis
//
//  Created by user on 20/03/2023.
//

import UIKit

class AppFullScreenController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let appView = UIView()
    
    let closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark.circle")
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    var todayItem: TodayItem?
    var dismissHandler: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        setupUI()
    }
    
    private let appViewBottomInset: CGFloat = 36
    private let appViewBottomOffset: CGFloat = 100
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            var transformY: CGAffineTransform = .identity
            if scrollView.contentOffset.y > 100 {
                transformY = CGAffineTransform(translationX: 0, y: -(self.appViewBottomOffset + self.appViewBottomInset))
            }
            self.appView.transform = transformY
        }
    }
}


extension AppFullScreenController: UITableViewDelegate, UITableViewDataSource {
    
    func setupUI() {
        setupTableView()
        setUpCloseButton()
        setupAppView()
    }
    
    func setupAppView() {
        
        appView.clipsToBounds = true
        appView.layer.cornerRadius = 12
        view.addSubview(appView)
        appView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: -appViewBottomOffset, right: 20), size: .init(width: 0, height: 72))
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        appView.addSubview(blurView)
        blurView.fillSuperview()
        
        let imageView = UIImageView(cornerRadius: 12)
        imageView.image = #imageLiteral(resourceName: "garden")
        imageView.constrainWidth(constant: 56)
        imageView.constrainHeight(constant: 56)
        
        let appLabel = UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 18))
        
        let titleAppLabel = UILabel(text: "Utilizing your time", font: .systemFont(ofSize: 16))
        
        let getButton = UIButton(title: "GET")
        getButton.layer.cornerRadius = 14
        getButton.backgroundColor = .darkGray
        getButton.tintColor = .white
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        getButton.constrainWidth(constant: 72)
        
        let stackView = UIStackView(arrangedSubviews: [imageView,
                                                       VerticalStackView(arrangedSubviews: [appLabel, titleAppLabel], spacing: 4),
                                                       getButton], customSpacing: 12)
        stackView.alignment = .center
        appView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 12, bottom: 0, right: 12))
        
        
    }
    
    func setUpCloseButton() {
        closeButton.addTarget(self, action: #selector(didTapped(handler:)), for: .touchUpInside)
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 12), size: .init(width: 38, height: 38))
    }
    
    @objc private func didTapped(handler: UIButton) {
        handler.isHidden = true
        dismissHandler?()
    }
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = .init(top: 0, left: 0, bottom: 48, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
            let cell = AppFullScreenHeaderCell()
            cell.todayCell.todayItem = todayItem
            cell.todayCell.contentView.layer.cornerRadius = 0
            return cell
        }
        
        let cell = AppDescriptionCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return TodayAppController.cellHeight
        }
        
        return UITableView.automaticDimension
        
    }
    
}
