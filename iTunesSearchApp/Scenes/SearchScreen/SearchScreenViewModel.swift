//
//  SearchScreenViewModel.swift
//  iTunesSearchApp
//
//  Created by Nilay Keven on 31.12.2020.
//

import Foundation

class SearchScreenViewModel {
   
    public var searchedItems = [ItemData]()
    public var page: Int = 1
    
    func search(with term: String, mediaType: String, onComplete: @escaping () -> ()) {
        let formattedSearchText = term.replacingOccurrences(of: " ", with: "+")
        SearchAPI.search(term: formattedSearchText, mediaType: mediaType, page: page).retrieve { [weak self] (items: SearchResult?) in
            guard let self = self, let items = items?.results else { return }
            self.setSearchResultAsData(items: items)
            onComplete()
        }
    }
    
    private func setSearchResultAsData(items: [Item]) {
        for item in items {
            let imageUrl = URL(string: item.artworkUrl100 ?? "")
            let releaseDate = formatReleaseDate(date: item.releaseDate ?? "")
            let description = item.longDescription ?? item.description
            searchedItems.append(ItemData(name: item.trackName, releaseDate: releaseDate, imageUrl: imageUrl, price: item.trackPrice, currency: item.currency, description: description))
        }
    }
    
    private func formatReleaseDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateWithTimeZone
        let date = dateFormatter.date(from: date)!
        dateFormatter.dateFormat = Constants.dateWithoutTimeZone
        return dateFormatter.string(from: date)
    }
}
