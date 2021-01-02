//
//  SearchScreenModel.swift
//  iTunesSearchApp
//
//  Created by Nilay Keven on 31.12.2020.
//

import Foundation

struct Item: Codable {
    let wrapperType: String?
    let kind: String?
    let trackId: Int?
    let collectionName: String?
    let collectionPrice: Double?
    let artistName: String?
    let trackName: String?
    let trackPrice: Double?
    let trackCensoredName: String?
    let trackViewUrl: String?
    let artworkUrl100: String?
    let releaseDate: String?
    let country: String?
    let currency: String?
    let description: String?
    let shortDescription: String?
    let longDescription: String?
}

struct SearchResult: Codable {
    var resultCount: Int?
    var results: [Item]?
}
