//
//  AppSearchController.swift
//  AppStoreJSONApis
//
//  Created by user on 03/03/2023.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "Cell"

class AppSearchController: UICollectionViewController {
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    private var searchLabel: UILabel = {
       let label = UILabel()
        label.text = "Please, enter search term above..."
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(white: 0.3, alpha: 0.7)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.addSubview(searchLabel)
        searchLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        
        // Register cell classes
        self.collectionView!.register(SearchResultCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        setUpSearchBar()
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup SearchBar
    
    private func setUpSearchBar() {
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
        
    }
    
    // MARK: - Fetching data
    private var searchResult = [Result]()
    
    private func fetchItunesApps() {
        
        Service.shared.fetchData(searchTerm: "instagram", with: { result, error in
            
            if let err = error {
                print("Failed to fetch apps: ", err)
                return
            }
            
            self.searchResult = result
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
    
    
    // MARK: - Navigation
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch searchResult.count {
        case 0:
            searchLabel.isHidden = false
            navigationItem.hidesSearchBarWhenScrolling = false
        default:
            searchLabel.isHidden = true
            navigationItem.hidesSearchBarWhenScrolling = true
        }
        return searchResult.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchResultCell
        cell.result = self.searchResult[indexPath.item]
        return cell
    }
    
    
    
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
}

extension AppSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: 350)
    }
}

extension AppSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            Service.shared.fetchData(searchTerm: searchText) { res, err in
                if let err = err {
                    print("Failed to fetch apps: ", err)
                }
                self.searchResult = res
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
        }
        })
    }
}
