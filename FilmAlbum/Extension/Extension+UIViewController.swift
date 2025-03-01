//
//  Extension+UIViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

extension UIViewController {
    func setNavigationItemSearchBar() {
        let sc: UISearchController = UISearchController()
        sc.hidesNavigationBarDuringPresentation = false
        sc.automaticallyShowsCancelButton = false
        sc.searchBar.searchTextField.tintColor = UIColor.faWhite
        sc.searchBar.searchTextField.leftView?.tintColor = UIColor.faWhite
        sc.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "검색어를 입력하세요.", attributes: [.foregroundColor: UIColor.faGray])
        sc.searchBar.searchTextField.backgroundColor = .faDarkGray
        
        DispatchQueue.main.async {
            sc.searchBar.searchTextField.textColor = UIColor.faWhite
        }
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = sc
    }
}
