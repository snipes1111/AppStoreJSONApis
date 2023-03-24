//
//  Icons.swift
//  AppStoreJSONApis
//
//  Created by user on 03/03/2023.
//

enum Section: String {
    case today = "Today", search = "Search", apps = "Apps", music = "Music"
}

public struct Icons {
    static let shared = Icons()
    
    private var today = "doc.text.image"
    private var search = "magnifyingglass.circle"
    private var apps = "square.stack.3d.up.fill"
    private var music = "music.note.list"
    
    func getImage(section: Section) -> String {
        switch section {
        case .today:
            return today
        case .apps:
            return apps
        case .search:
            return search
        case .music:
            return music
        }
    }
}
