//
//  ProfileViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

import SnapKit

final class ProfileViewController: CustomBaseViewController {
    
    private let profileBannerView: ProfileBannerView = ProfileBannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileBannerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.profileBannerTapped)))
        
        self.view.addSubview(profileBannerView)
        
        self.profileBannerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(150)
        }
        
    }
    
    @objc private func profileBannerTapped() {
        let nc = UINavigationController(rootViewController: NicknameViewController(viewType: .nicknameEditing))
        nc.sheetPresentationController?.prefersGrabberVisible = true
        self.present(nc, animated: true)
    }
}
