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
    
    // TODO: profileImageType User 정보와 동기화
    private let editingView: NicknameEditingView = NicknameEditingView(profileImageType: ProfileImage.randomCase)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
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
}
