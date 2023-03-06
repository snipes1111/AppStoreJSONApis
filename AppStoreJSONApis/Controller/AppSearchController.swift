//
//  AppSearchController.swift
//  AppStoreJSONApis
//
//  Created by user on 03/03/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class AppSearchController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(SearchResultCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        fetchItunesApps()
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Fetching data
    private func fetchItunesApps() {
        let searchURL = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let searchURL = URL(string: searchURL) else { return }
        
        // fetch data from internet
        URLSession.shared.dataTask(with: searchURL) { data, response, error in
            
            if let err = error {
                print("Error URLrequest:", err)
            }
            
            /*
            // success
            print(data)
            print(String(data: data!, encoding: .utf8))
            */
            
            guard let searchData = data else { return }
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: searchData)
                print(searchResults.resultCount)
                searchResults.results.forEach { print($0.trackName, $0.primaryGenreName) }
            } catch let jsonErr {
                print("JSON error:", jsonErr)
            }
            
        }.resume() // fires off the request
        
    }
    

    // MARK: - Navigation
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchResultCell
        cell.categoryLabel.text = "This is my app"
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
