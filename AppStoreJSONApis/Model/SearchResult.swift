//
//  SearchResult.swift
//  AppStoreJSONApis
//
//  Created by user on 06/03/2023.
//

import Foundation

struct SearchResult: Decodable {
    var resultCount: Int
    var results: [Result]
}

struct Result: Decodable {
    var trackName: String
    var primaryGenreName: String
    var userRatingCount: Int?
    var artworkUrl100: String // app icon 100*100
    var screenshotUrls: [String]
    
}
