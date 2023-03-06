//
//  SearchResult.swift
//  AppStoreJSONApis
//
//  Created by user on 06/03/2023.
//

import Foundation

struct SearchResults: Decodable {
    var resultCount: Int
    var results: [Result]
}

struct Result: Decodable {
    var trackName: String
    var primaryGenreName: String
    var userRatingCount: Int
    
}
