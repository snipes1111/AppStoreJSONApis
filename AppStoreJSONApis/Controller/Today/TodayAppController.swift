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
    
    private var topConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    private var startingFrame: CGRect?
    
    lazy var tabBarHeight = tabBarController?.tabBar.frame.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.9019607902, green: 0.9019607902, blue: 0.9019607902, alpha: 1)
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
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let todaiItem = todayItems[indexPath.item]
        
        if todaiItem.cellType == .single {
            presentSingleCell(indexPath: indexPath)
        } else {
            let vc = TodayMultipleAppController(mode: .fullScreen)
            vc.appResults = todaiItem.feedResult
            present(vc, animated: true)
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

extension TodayAppController {
    // moving top constraint for cell up and down
    
    enum Direction: CGFloat {
        case up = 48
        case down = 24
    }
    
    private func moveTopConstraint(direction: Direction) {
        
        if let cell = self.appFullScreenController.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell {
            cell.todayCell.topConstraint?.constant = direction.rawValue
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
    
    private func presentSingleCell(indexPath: IndexPath) {
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
            
            self.moveTopConstraint(direction: .up)
        }
    }
    
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
            
            self.moveTopConstraint(direction: .down)
            
        } completion: { _ in
            
            self.appFullScreenController.view.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        }
        
    }
}

