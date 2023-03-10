//
//  ServiceAPI.swift
//  AppStoreJSONApis
//
//  Created by user on 06/03/2023.
//

import Foundation

class Service {
    static var shared = Service()
    
    func fetchData(searchTerm: String, with completion: @escaping (SearchResult?, Error?) -> ()) {
        fetchGenericJSONData(urlString: "https://itunes.apple.com/search?term=\(searchTerm)&entity=software", completion: completion)
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
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchAppHeaderApps(completion: @escaping ([AppHeaderApps]?, Error?) -> Void) {
        fetchGenericJSONData(urlString: "http://api.letsbuildthatapp.com/appstore/social", completion: completion)
    }
    
    // implement generic
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, res, err in
            if let err = err {
                print("Error to fetch data:", err)
                completion(nil, err)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(objects, nil)

            } catch {
                print("Failed to decode JSON: ", error)
                completion(nil, error)
            }
            
        }.resume()
    }
    
}
