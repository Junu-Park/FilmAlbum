//
//  SearchViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

final class SearchViewController: CustomBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationItemSearchBar()
        self.navigationItem.searchController?.searchBar.delegate = self
    }
}
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if let searchTerm = searchBar.text, !searchTerm.isEmpty {
            return true
        } else {
            return false
        }
    }
}
