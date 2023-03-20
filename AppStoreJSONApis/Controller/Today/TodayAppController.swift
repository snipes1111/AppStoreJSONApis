//
//  TodayController.swift
//  AppStoreJSONApis
//
//  Created by user on 17/03/2023.
//

import UIKit

class TodayAppController: BaseSectionController {
    
    private let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.9019607902, green: 0.9019607902, blue: 0.9019607902, alpha: 1)
        navigationController?.isNavigationBarHidden = true
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TodayCell
        return cell
    }
    
    lazy var tabBarHeight = tabBarController?.tabBar.frame.size.height
    private var appFullScreenController: UIViewController!
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        
        appFullScreenController = AppFullScreenController()
        addChild(appFullScreenController)
        
        let appFullScreenView = appFullScreenController.view!
        appFullScreenView.frame = startingFrame
        appFullScreenView.layer.cornerRadius = 12
        view.addSubview(appFullScreenView)
        view.layoutIfNeeded()
        
        appFullScreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            appFullScreenView.frame = self.view.frame
            self.tabBarController?.tabBar.frame.origin.y += self.tabBarHeight ?? 0
            self.navigationController?.view.layoutIfNeeded()
        }
    }
    
    private var startingFrame: CGRect?
    
    @objc func handleRemoveRedView(gesture: UIGestureRecognizer) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            gesture.view?.frame = self.startingFrame ?? .zero
            self.tabBarController?.tabBar.frame.origin.y -= self.tabBarHeight ?? 0
            self.navigationController?.view.layoutIfNeeded()
        } completion: { _ in
            gesture.view?.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
        }
        
    }
    
}

extension TodayAppController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width - 64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 20, left: 0, bottom: 20, right: 0)
    }
}
