//
//  AppResults.swift
//  AppStoreJSONApis
//
//  Created by user on 09/03/2023.
//

import Foundation

struct AppResult: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResults]
}

struct FeedResults: Decodable {
    let name: String
    let artistName: String
    let artworkUrl100: String // app icon 100*100
    let id: String
}
