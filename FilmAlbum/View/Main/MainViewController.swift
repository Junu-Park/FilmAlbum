//
//  MainViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

import SnapKit

final class MainViewController: CustomBaseViewController {

    private let profileBannerView: ProfileBannerView = ProfileBannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationItem()
        
        self.view.addSubview(profileBannerView)
        
        self.profileBannerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(150)
        }
    }
    
    private func configureNavigationItem() {
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage.faMagnifyingglass, style: .plain, target: self, action: #selector(self.searchButtonTapped)), animated: true)
    }
    
    @objc private func searchButtonTapped() {
        
    }
}
