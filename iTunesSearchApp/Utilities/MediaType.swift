//
//  MediaType.swift
//  iTunesSearchApp
//
//  Created by Nilay Keven on 2.01.2021.
//

import Foundation

public enum MediaType: String, CaseIterable {
    case all = "all"
    case movie = "movie"
    case music = "music"
    case app = "software"
    case book = "ebook"
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case .movie:
            return "Movies"
        case .music:
            return "Musics"
        case .app:
            return "Apps"
        case .book:
            return "Books"
        }
    }
}
