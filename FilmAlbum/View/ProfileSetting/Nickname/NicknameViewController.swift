//
//  NicknameViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

import SnapKit

final class NicknameViewController: CustomBaseViewController {
    
    private let settingView: NicknameSettingView = NicknameSettingView(profileImageType: UserDataManager.getSetProfileImage())
    
    private let editingView: NicknameEditingView = NicknameEditingView(profileImageType: UserDataManager.getSetProfileImage())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureHierarchy()
        self.configureProfileImageViewTapGesture()
    }
    
    private func configureHierarchy() {
        if self.viewType == .nicknameSetting {
            self.view = self.settingView
        } else if self.viewType == .nicknameEditing {
            self.view = self.editingView
        } else {
            print(#function, "viewType error")
        }
    }
    
    private func configureProfileImageViewTapGesture() {
        if self.viewType == .nicknameSetting {
            let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
            self.settingView.profileImageView.addGestureRecognizer(gestureRecognizer)
        } else if self.viewType == .nicknameEditing {
            
        } else {
            print(#function, "viewType error")
        }
    }
    
    @objc private func profileImageViewTapped() {
        let vc: ProfileImageViewController = ProfileImageViewController(viewType: .imageSetting, selectedProfileImageType: self.settingView.profileImageView.profileImageType)
        vc.settingView.closure = { selectedProfileImageType in
            self.settingView.profileImageView.profileImageType = selectedProfileImageType
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
