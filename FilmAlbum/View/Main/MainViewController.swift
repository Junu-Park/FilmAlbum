//
//  MainViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

final class MainViewController: CustomBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationItem()
    }
    
    private func configureNavigationItem() {
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage.faMagnifyingglass, style: .plain, target: self, action: #selector(self.searchButtonTapped)), animated: true)
    }
    
    @objc private func searchButtonTapped() {
        
    }
}
