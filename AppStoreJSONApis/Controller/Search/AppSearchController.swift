//
//  AppSearchController.swift
//  AppStoreJSONApis
//
//  Created by user on 03/03/2023.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "SearchCell"

class AppSearchController: BaseSectionController {
    
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
        
        collectionView!.register(SearchResultCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        setUpSearchBar()
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
            
            self.searchResult = result?.results ?? []
            
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
    
}

extension AppSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: 350)
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
                self.searchResult = res?.results ?? []
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
}
