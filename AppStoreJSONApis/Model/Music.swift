//
//  Music.swift
//  AppStoreJSONApis
//
//  Created by user on 24/03/2023.
//

import Foundation

struct MusicSearchResult: Decodable {
    let resultCount: Int
    let results: [MusicResult]
}

struct MusicResult: Decodable {
    let artistName: String
    let collectionName: String?
    let artworkUrl100: String // album icon 100*100
    let trackName: String?
}
