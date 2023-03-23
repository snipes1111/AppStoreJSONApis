//
//  TodayController.swift
//  AppStoreJSONApis
//
//  Created by user on 17/03/2023.
//

import UIKit

class TodayAppController: BaseSectionController {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .darkGray
        activity.startAnimating()
        activity.hidesWhenStopped = true
        return activity
    }()
    
    private var todayItems = [TodayItem]()
    
    private var appFullScreenController: AppFullScreenController!
    private var anchorConstraints: AnchoredConstraints?
    private var startingFrame: CGRect?
    
    private var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    lazy var tabBarHeight = tabBarController?.tabBar.frame.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(blurView)
        blurView.fillSuperview()
        blurView.alpha = 0
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9019607902, green: 0.9019607902, blue: 0.9019607902, alpha: 1)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 12, right: 0)
        navigationController?.isNavigationBarHidden = true
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        view.addSubview(activityIndicator)
        activityIndicator.fillSuperview()
        fetchData()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        todayItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let typeCell = todayItems[indexPath.item].cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: typeCell, for: indexPath) as! BaseTodayCell
        cell.todayItem = todayItems[indexPath.item]
        
        (cell as? TodayMultipleAppCell)?.appCollectionViewController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
        
        return cell
    }
    
    @objc private func handleMultipleAppsTap(gesture: UITapGestureRecognizer) {
        let collectionView = gesture.view
        var superView = collectionView?.superview
        while superView != nil {
            if let cell = superView as? TodayMultipleAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                presentMultipleCell(indexPath: indexPath)
            }
            superView = superView?.superview
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch todayItems[indexPath.item].cellType {
        case .single:
            presentSingleCell(indexPath: indexPath)
        case .multiple:
            presentMultipleCell(indexPath: indexPath)
        }
    }
    
}

extension TodayAppController: UICollectionViewDelegateFlowLayout {
    
    static let cellHeight: CGFloat = 450
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width - 64, height: TodayAppController.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32
    }
    
}

extension TodayAppController: UIGestureRecognizerDelegate {
    // moving top constraint for cell up and down
    
    enum Direction: CGFloat {
        case up = 48
        case down = 24
    }
    
    private func moveTopConstraint(direction: Direction) {
        
        if let cell = self.appFullScreenController.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell {
            cell.todayCell.topConstraint?.constant = direction.rawValue
            
            if direction == .down {
                cell.closeButton.alpha = 0
            }
            
            cell.layoutIfNeeded()
        }
    }
    
    private func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        var topFreeApps: AppResult?
        var topPaidApps: AppResult?
        dispatchGroup.enter()
        
        Service.shared.fetchTopFree { appresult, err in
            dispatchGroup.leave()
            if let err = err {
                print("Error to fetch today top free apps: ", err)
            }
            topFreeApps = appresult
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopPaid { appresult, err in
            dispatchGroup.leave()
            if let err = err {
                print("Error to fetch today top free apps: ", err)
            }
            topPaidApps = appresult
        }
        
        dispatchGroup.notify(queue: .main) { [unowned self] in
            todayItems = [
                TodayItem(category: "LIFE HACK", title: "Utilizing your Time", descriptionText: "All the tools and apps you need to intelligently orginize your life the right way!", image: #imageLiteral(resourceName: "garden"), backGroundColor: .white, cellType: .single, feedResult: []),
                TodayItem.init(category: "DAILY LIST", title: topPaidApps?.feed.title ?? "", descriptionText: "", image: #imageLiteral(resourceName: "garden"), backGroundColor: .white, cellType:  .multiple, feedResult: topPaidApps?.feed.results ?? []),
                TodayItem(category: "HOLIDAYS", title: "Travel on a budget", descriptionText: "Find out all you need to know on how to travel without packing everything!", image: #imageLiteral(resourceName: "holiday"), backGroundColor: #colorLiteral(red: 0.9808613658, green: 0.9632887244, blue: 0.7228078246, alpha: 1), cellType: .single, feedResult: []),
                TodayItem(category: "DAILY LIST", title: topFreeApps?.feed.title ?? "", descriptionText: "", image: #imageLiteral(resourceName: "garden"), backGroundColor: .white, cellType:  .multiple, feedResult: topFreeApps?.feed.results ?? [])
            ]
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
            
        }
    }
    
    private func presentMultipleCell(indexPath: IndexPath) {
        let todayItem = todayItems[indexPath.item]
        let appListController = TodayMultipleAppController(mode: .fullScreen)
        let navVC = BackEnabledNavigationController(rootViewController: appListController)
        appListController.appResults = todayItem.feedResult
        navVC.modalPresentationStyle = .automatic
        present(navVC, animated: true)
    }
    
    private func presentSingleCell(indexPath: IndexPath) {
        self.collectionView.isUserInteractionEnabled = false
        
        // #1 Setup appFullScreenController
        setupAppFullScreenController(indexPath: indexPath)
        
        // #2 Calculate absolute cell's frame, setup appFullScreenController's view to it's start position and constraints for starting animation
        
        setupAppFullScreenView(indexPath: indexPath)
        
        // #3 Animation transition
        
        beginAnimationAppFullScreenView()
    }
    
    private func setupAppFullScreenController(indexPath: IndexPath) {
        
        appFullScreenController = AppFullScreenController()
        appFullScreenController.dismissHandler = { self.handleRemoveAppFullScreenView() }
        appFullScreenController.todayItem = todayItems[indexPath.item]
        
        // #1 Setup gesture
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag))
        gesture.delegate = self
        appFullScreenController.view.addGestureRecognizer(gesture)
        // #2 Add a blur effect to a view
        
        // #3 Not to enterfere with tableview scrolling
    }
    
    @objc private func handleDrag(gesture: UIPanGestureRecognizer) {
        let translationY = gesture.translation(in: appFullScreenController.view).y
        var appFullScreenBeginOffset: CGFloat = 0
        
        if gesture.state == .began { appFullScreenBeginOffset = appFullScreenController.tableView.contentOffset.y }
        if appFullScreenBeginOffset > 0 { return }
        if translationY > 0 {
            let trueOffset = translationY - appFullScreenBeginOffset
            var scale = 1 - trueOffset / 1000
            scale = min(1, scale)
            scale = max(0.5, scale)
            appFullScreenController.view.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            if gesture.state == .ended { handleRemoveAppFullScreenView() }
        }
    }
    
    private func handleRemoveAppFullScreenView() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            
            self.blurView.alpha = 0
            
            guard let startingFrame = self.startingFrame else { return }

            self.anchorConstraints?.top?.constant = startingFrame.origin.y
            self.anchorConstraints?.leading?.constant = startingFrame.origin.x
            self.anchorConstraints?.width?.constant = startingFrame.width
            self.anchorConstraints?.height?.constant = startingFrame.height
            self.tabBarController?.tabBar.frame.origin.y -= self.tabBarHeight ?? 0
            
            //this method used for to restore appVCView properties after dragging it to remove from view
            self.appFullScreenController.view.transform = .identity
            
            self.view.layoutIfNeeded()
            
            self.appFullScreenController.tableView.contentOffset = .zero
            
            
            self.moveTopConstraint(direction: .down)
            
        } completion: { _ in
            
            self.appFullScreenController.view.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        }
        
    }
    
    private func setupAppFullScreenView(indexPath: IndexPath) {
        
        let appFullScreenView = appFullScreenController.view!
        appFullScreenView.layer.cornerRadius = 12
        addChild(appFullScreenController)
        view.addSubview(appFullScreenView)
        
        calculateStartingPosition(indexPath: indexPath)
        
        guard let startingFrame = self.startingFrame else { return }
        
        let anchorConstraints = appFullScreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
        self.anchorConstraints = anchorConstraints
        view.layoutIfNeeded() // starts animation
    }
    
    private func calculateStartingPosition(indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
    }
    
    private func beginAnimationAppFullScreenView() {
       
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            
            self.blurView.alpha = 1
            
            self.anchorConstraints?.top?.constant = 0
            self.anchorConstraints?.leading?.constant = 0
            self.anchorConstraints?.width?.constant = self.view.frame.width
            self.anchorConstraints?.height?.constant = self.view.frame.height
            self.tabBarController?.tabBar.frame.origin.y += self.tabBarHeight ?? 0
            self.view.layoutIfNeeded()
            
            self.moveTopConstraint(direction: .up)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

