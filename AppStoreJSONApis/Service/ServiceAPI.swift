//
//  ServiceAPI.swift
//  AppStoreJSONApis
//
//  Created by user on 06/03/2023.
//

import Foundation

class Service {
    static var shared = Service()
    
    func fetchData(with completion: @escaping ([Result], Error?) -> ()) {
        let searchURL = "https://itunes.apple.com/search?term=instagram&entity=software"
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
}
