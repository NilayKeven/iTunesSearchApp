//
//  SearchScreenViewModel.swift
//  iTunesSearchApp
//
//  Created by Nilay Keven on 31.12.2020.
//

import Foundation

class SearchScreenViewModel {
    
    init() {
        
    }
    
    public var searchedItems = [ItemCellData]()
    
    func search(with term: String, onComplete: @escaping () -> ()) {
        let formattedSearchText = term.replacingOccurrences(of: " ", with: "+")
        SearchAPI.search(term: formattedSearchText).retrieve { [weak self] (items: SearchResult?) in
            guard let self = self, let searchedItems = items?.results else { return }
            self.searchedItems.removeAll()
            self.setSearchResultAsData(items: searchedItems)
            onComplete()
        }
    }
    
    private func setSearchResultAsData(items: [Item]) {
        for item in items {
            let imageUrl = URL(string: item.artworkUrl100 ?? "")
            let releaseDate = formatReleaseDate(date: item.releaseDate ?? "")
            searchedItems.append(ItemCellData(name: item.collectionName, releaseDate: releaseDate, imageUrl: imageUrl, price: item.collectionPrice, currency: item.currency))
        }
    }
    
    private func formatReleaseDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: date)!
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}
