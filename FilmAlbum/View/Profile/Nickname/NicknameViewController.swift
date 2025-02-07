//
//  NicknameViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

import SnapKit

final class NicknameViewController: CustomBaseViewController {
    
    private let settingView: NicknameSettingView = NicknameSettingView(profileImageType: ProfileImageType.getRandomCase())
    
    private let editingView: NicknameEditingView = NicknameEditingView(profileImageType: UserDataManager.getSetProfileImage())
    
    private let viewModel: ProfileSettingViewModel = ProfileSettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.viewType == .nicknameEditing {
            editingView.nicknameTextFieldView.nicknameTextField.delegate = self
        }
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
            let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
            self.editingView.profileImageView.addGestureRecognizer(gestureRecognizer)
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
        if self.viewType == .nicknameSetting {
            self.viewModel.profileImageViewTappedIn.value = ()
        } else if self.viewType == .nicknameEditing {
            let vc: ProfileImageViewController
            vc = ProfileImageViewController(viewType: .imageEditing, selectedProfileImageType: self.editingView.profileImageView.profileImageType)
            vc.editingView.closure = { selectedProfileImageType in
                self.editingView.profileImageType = selectedProfileImageType
            }
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc: ProfileImageViewController
            vc = ProfileImageViewController(viewType: .error, selectedProfileImageType: .profile0)
            print(#function, "viewType error")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        UserDataManager.getSetNickname(newNickname: editingView.nicknameTextFieldView.nicknameTextField.text)
        UserDataManager.getSetProfileImage(newProfileImageType: editingView.profileImageType)
        NotificationCenter.default.post(name: NSNotification.Name("ProfileEditing"), object: nil)
        self.dismiss(animated: true)
    }
    
    override func binding() {
        self.viewModel.profileImageViewTappedOut.closure = { _, _ in
            let vc: ProfileImageViewController
            vc = ProfileImageViewController(viewType: .imageSetting, selectedProfileImageType: self.settingView.profileImageView.profileImageType)
            vc.settingView.closure = { selectedProfileImageType in
                self.settingView.profileImageType = selectedProfileImageType
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension NicknameViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.editingView.nicknameState = self.editingView.nicknameTextFieldView.nicknameTextField.text.checkNicknameValidation()
        self.navigationItem.rightBarButtonItem?.isEnabled = self.editingView.nicknameState == NicknameTextFieldState.ok
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.editingView.nicknameState = textField.text.checkNicknameValidation()
        if self.editingView.nicknameState == .ok {
            self.view.endEditing(true)
        }
        return true
    }
}
