//
//  AppHeader.swift
//  AppStoreJSONApis
//
//  Created by user on 10/03/2023.
//

import Foundation

struct AppHeaderApps: Decodable, Hashable {
    var id, name, tagline, imageUrl: String
}
