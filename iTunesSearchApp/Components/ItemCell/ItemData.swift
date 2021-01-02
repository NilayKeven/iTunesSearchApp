//
//  ItemCellData.swift
//  iTunesSearchApp
//
//  Created by Nilay Keven on 1.01.2021.
//

import Foundation

public class ItemData {
    
    private(set) var name: String?
    private(set) var releaseDate: String?
    private(set) var imageUrl: URL?
    private(set) var price: Double?
    private(set) var currency: String?
    private(set) var description: String?
    
    public init(name: String?, releaseDate: String?, imageUrl: URL?,
                price: Double?, currency: String?, description: String?) {
        self.name = name
        self.releaseDate = releaseDate
        self.imageUrl = imageUrl
        self.price = price
        self.currency = currency
        self.description = description
    }
}
