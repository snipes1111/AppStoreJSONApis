//
//  ServiceAPI.swift
//  AppStoreJSONApis
//
//  Created by user on 06/03/2023.
//

import Foundation

class Service {
    static var shared = Service()
    
    func fetchData(searchTerm: String, with completion: @escaping ([Result], Error?) -> ()) {
        let searchURL = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let searchURL = URL(string: searchURL) else { return }
        
        // fetch data from internet
        URLSession.shared.dataTask(with: searchURL) { data, response, error in
            
            if let err = error {
                print("Failed to fetch apps: ", err)
                completion([], nil)
                return
            }
            
            guard let searchData = data else { return }
            
            do {
                
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: searchData)
                completion(searchResult.results, nil)
                
                
            } catch let jsonErr {
                print("JSON error: ", jsonErr)
                completion([], jsonErr)
            }
            
        }.resume() // fires off the request
    }
    
    func fetchTopFree(with completion: @escaping (AppResult?, Error?)->()) {
        fetchGroup(urlString: "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/25/apps.json", completion: completion)
    }
    
    func fetchTopPaid(with completion: @escaping (AppResult?, Error?)->()) {
        fetchGroup(urlString: "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/25/apps.json", completion: completion)
    }
    
    func fetchTopMusic(with completion: @escaping (AppResult?, Error?)->()) {
        fetchGroup(urlString: "https://rss.applemarketingtools.com/api/v2/us/music/most-played/25/albums.json", completion: completion)
    }
    
    // helpers
    func fetchGroup(urlString: String, completion: @escaping (AppResult?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, res, err in
            if let err = err {
                print("Error to fetch data:", err)
                completion(nil, err)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let appResult = try JSONDecoder().decode(AppResult.self, from: data)
                completion(appResult, nil)

            } catch {
                print("Failed to decode JSON: ", error)
                completion(nil, error)
            }
            
        }.resume()
    }
    
    func fetchAppHeaderApps(completion: @escaping ([AppHeaderApps]?, Error?) -> Void) {
        guard let url = URL(string: "http://api.letsbuildthatapp.com/appstore/social") else { return }
        URLSession.shared.dataTask(with: url) { data, res, err in
            if let err = err {
                print("Error to fetch data:", err)
                completion(nil, err)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let headerApps = try JSONDecoder().decode([AppHeaderApps].self, from: data)
                completion(headerApps, nil)

            } catch {
                print("Failed to decode JSON: ", error)
                completion(nil, error)
            }
            
        }.resume()
    }
    
}
