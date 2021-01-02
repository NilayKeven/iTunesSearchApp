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
    private let collectionCellIdentifier = "ItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupDelegates()
    }
    
    private func setupDelegates() {
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: collectionCellIdentifier, bundle: nil), forCellWithReuseIdentifier: collectionCellIdentifier)
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
        if searchedText.count != 0 {
            viewModel.search(with: searchedText, mediaType: selectedMediaType) {
                self.refreshCollectionView()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        selectedMediaType = MediaType.allCases[selectedScope].rawValue
        resetScrollPosition()
        viewModel.searchedItems.removeAll()
        collectionView.reloadData()
        searchBarSearchButtonClicked(searchBar)
    }
    
    private func resetScrollPosition() {
        let topOffest:CGPoint = CGPoint(x: 0, y: -collectionView.contentInset.top)
        collectionView?.setContentOffset(topOffest, animated: true)
    }
}

extension SearchScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as? ItemCell
        cell?.item = viewModel.searchedItems[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Navigate to item detail
        let itemDetailViewModel = ItemDetailViewModel(item: viewModel.searchedItems[indexPath.row])
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let itemDetailViewController = storyboard.instantiateViewController(withIdentifier: "ItemDetailViewController") as? ItemDetailViewController {
            itemDetailViewController.viewModel = itemDetailViewModel
            navigationController?.pushViewController(itemDetailViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Display cell --- Offset
        if viewModel.searchedItems.count - 1 == indexPath.row {
            viewModel.page += 1
            viewModel.search(with: searchedText, mediaType: selectedMediaType) {
                self.refreshCollectionView()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width / 2.0) - 20
        let cellHeight = cellWidth + 100
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
