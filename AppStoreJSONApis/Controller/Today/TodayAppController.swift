//
//  TodayController.swift
//  AppStoreJSONApis
//
//  Created by user on 17/03/2023.
//

import UIKit

class TodayAppController: BaseSectionController {
    
    private let reuseIdentifier = "cell"
    private let todayItems = [
        TodayItem(category: "LIFE HACK", title: "Utilizing your Time", descriptionText: "All the tools and apps you need to intelligently orginize your life the right way", image: #imageLiteral(resourceName: "garden"), backGroundColor: .white),
        TodayItem(category: "HOLIDAYS", title: "Travel on a budget", descriptionText: "Find out all you need to know on how to travel without packing everything!", image: #imageLiteral(resourceName: "holiday"), backGroundColor: #colorLiteral(red: 0.9808613658, green: 0.9632887244, blue: 0.7228078246, alpha: 1))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.9019607902, green: 0.9019607902, blue: 0.9019607902, alpha: 1)
        navigationController?.isNavigationBarHidden = true
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        todayItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TodayCell
        cell.todayItem = todayItems[indexPath.item]
        return cell
    }
    
    lazy var tabBarHeight = tabBarController?.tabBar.frame.size.height
    private var appFullScreenController: AppFullScreenController!
    
    private var topConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.collectionView.isUserInteractionEnabled = false
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        
        appFullScreenController = AppFullScreenController()
        appFullScreenController.dismissHandler = { self.handleRemoveRedView() }
        appFullScreenController.todayItem = todayItems[indexPath.item]
        addChild(appFullScreenController)
        
        let appFullScreenView = appFullScreenController.view!
        appFullScreenView.layer.cornerRadius = 12
        view.addSubview(appFullScreenView)
        
        appFullScreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = appFullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = appFullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = appFullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = appFullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach { $0?.isActive = true }
        view.layoutIfNeeded() // starts animation

        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
        
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            self.tabBarController?.tabBar.frame.origin.y += self.tabBarHeight ?? 0
            self.view.layoutIfNeeded()
            
            if let cell = self.appFullScreenController.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell {
                cell.todayCell.topConstraint?.constant = 48
                cell.layoutIfNeeded()
            }
        }
    }
    
    private var startingFrame: CGRect?
    
    private func handleRemoveRedView() {

        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            
            guard let startingFrame = self.startingFrame else { return }
    
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            self.tabBarController?.tabBar.frame.origin.y -= self.tabBarHeight ?? 0
            
            self.view.layoutIfNeeded()
            
            self.appFullScreenController.tableView.contentOffset = .zero
            
            if let cell = self.appFullScreenController.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell {
                cell.todayCell.topConstraint?.constant = 24
                cell.layoutIfNeeded()
            }
            
        } completion: { _ in
            
            self.appFullScreenController.view.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        }
        
    }
    
}

extension TodayAppController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width - 64, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32
    }
    
}
    
