//
//  NicknameViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

import SnapKit

final class NicknameViewController: CustomBaseViewController {
    
    private let settingView: NicknameSettingView = NicknameSettingView(profileImageType: ProfileImage.randomCase)
    
    private let editingView: NicknameEditingView = NicknameEditingView(profileImageType: UserDataManager.getSetProfileImage())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureHierarchy()
        self.configureProfileImageViewTapGesture()
        self.configureNavigationItem()
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
    
    private func configureNavigationItem() {
        if self.viewType == .nicknameSetting {
            return
        } else if self.viewType == .nicknameEditing {
            self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage.faXmark, style: .plain, target: self, action: #selector(closeButtonTapped)), animated: true)
            self.navigationItem.setRightBarButton(UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped)), animated: true)
        } else {
            print(#function, "viewType error")
        }
    }
    
    @objc private func profileImageViewTapped() {
        let vc: ProfileImageViewController = ProfileImageViewController(viewType: .imageSetting, selectedProfileImageType: self.settingView.profileImageView.profileImageType)
        vc.settingView.closure = { selectedProfileImageType in
            self.settingView.profileImageType = selectedProfileImageType
        }
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        self.dismiss(animated: true)
    }
}
