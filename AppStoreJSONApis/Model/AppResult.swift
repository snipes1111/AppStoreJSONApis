//
//  AppResults.swift
//  AppStoreJSONApis
//
//  Created by user on 09/03/2023.
//

import Foundation

struct AppResult: Decodable {
    var feed: Feed
}

struct Feed: Decodable {
    var title: String
    var results: [FeedResults]
}

struct FeedResults: Decodable {
    var name: String
    var artistName: String
    var artworkUrl100: String // app icon 100*100
}
