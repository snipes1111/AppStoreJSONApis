//
//  SearchResult.swift
//  AppStoreJSONApis
//
//  Created by user on 06/03/2023.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    let userRatingCount: Int?
    let artworkUrl100: String // app icon 100*100
    let screenshotUrls: [String]
    let formattedPrice: String?
    let version: String
    let releaseNotes: String?
}

