//
//  MainTabBarController.swift
//  AppStoreJSONApis
//
//  Created by user on 03/03/2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            createNavController(viewController: MusicController(), title: Section.music.rawValue, image: Icons.shared.getImage(section: .music)),
            createNavController(viewController: TodayAppController(), title: Section.today.rawValue, image: Icons.shared.getImage(section: .today)),
            createNavController(viewController: AppPageController(), title: Section.apps.rawValue, image: Icons.shared.getImage(section: .apps)),
            createNavController(viewController: AppSearchController(), title: Section.search.rawValue, image: Icons.shared.getImage(section: .search))
        ]
        
    }
    
    // MARK: - SetUp TabBar's VCs
    fileprivate func createNavController(viewController: UIViewController, title: String, image systemName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: systemName)
        navController.navigationBar.prefersLargeTitles = true
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        return navController
    }
    

}
