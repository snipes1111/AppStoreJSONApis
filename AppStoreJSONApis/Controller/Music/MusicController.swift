//
//  MusicController.swift
//  AppStoreJSONApis
//
//  Created by user on 24/03/2023.
//

import UIKit

class MusicController: BaseSectionController {
    
    private var cellId = "cellId"
    private var footerId = "footerId"
    private var musicResults = [MusicResult]()
    private let searchTerm = "A$AP"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(TrackCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(MusicControllerFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
        fetchData()
    }
    
    private func fetchData() {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=20"
        
        Service.shared.fetchGenericJSONData(urlString: urlString) { (musicSearchResult: MusicSearchResult?, err) in
            
            if let err = err {
                print("Error to fetch music data: ", err)
                return
            }
            self.musicResults = musicSearchResult?.results ?? []
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    private var isPaginating = false
    private var isDonePaginating = false
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TrackCell
        cell.currentTrack = musicResults[indexPath.item]

        if indexPath.item == musicResults.count - 1 && !isPaginating {
            isPaginating = true
            let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(musicResults.count)&limit=20"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (musicSearchResult: MusicSearchResult?, err) in
                
                if let err = err {
                    print("Error to fetch music data: ", err)
                    return
                }
                
                if musicSearchResult?.results.count == 0 { self.isDonePaginating = false }
                
                self.musicResults += musicSearchResult?.results ?? []
                
                sleep(2)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                self.isPaginating = false
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        musicResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
        return footer
    }
    
}


extension MusicController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = isDonePaginating ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }
    
    
    
}
