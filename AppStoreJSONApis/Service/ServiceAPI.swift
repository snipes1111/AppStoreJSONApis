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
    
    func fetchGames(with completion: @escaping (AppResult?, Error?)->()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
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
    
    
}
