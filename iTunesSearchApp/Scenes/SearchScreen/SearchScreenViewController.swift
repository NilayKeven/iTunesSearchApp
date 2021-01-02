//
//  SearchScreenViewController.swift
//  iTunesSearchApp
//
//  Created by Nilay Keven on 31.12.2020.
//

import UIKit

class SearchScreenViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel = SearchScreenViewModel()
    private var searchedText: String = ""
    private var selectedMediaType: String = MediaType.all.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupDelegates()
    }
    
    private func setupDelegates() {
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
    }
    
    private func setupSearchBar() {
        searchBar.scopeButtonTitles = MediaType.allCases.map { $0.title }
        searchBar.selectedScopeButtonIndex = 0
        searchBar.showsScopeBar = true
    }
    
    private func refreshCollectionView() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            self.collectionView.reloadData()
        }
    }
}

extension SearchScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            self.searchedText = searchText
        } else if searchText.count == 0 {
            searchedText = searchText
            viewModel.searchedItems.removeAll()
            refreshCollectionView()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search(with: searchedText, mediaType: selectedMediaType) {
            self.refreshCollectionView()
        }
    }
}

extension SearchScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell
        cell?.item = viewModel.searchedItems[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width / 2.0) - 20
        let cellHeight = cellWidth + 100
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        selectedMediaType = MediaType.allCases[selectedScope].rawValue
        searchBarSearchButtonClicked(searchBar)
    }
    
}
