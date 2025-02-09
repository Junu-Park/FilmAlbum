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
        
        self.configureHierarchy()
        self.configureProfileImageViewTapGesture()
        self.configureNavigationItem()
        self.configureDelegate()
        self.configureAddTarget()
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
    
    private func configureDelegate() {
        if self.viewType == .nicknameSetting {
            self.settingView.nicknameTextFieldView.nicknameTextField.delegate = self
        } else {
            self.editingView.nicknameTextFieldView.nicknameTextField.delegate = self
        }
    }
    
    private func configureAddTarget() {
        if self.viewType == .nicknameSetting {
            self.settingView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
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
    
    @objc private func completeButtonTapped() {
        self.viewModel.profileSaveIn.value = ()
    }
    
    override func binding() {
        self.viewModel.profileImageViewTappedOut.closure = { [weak self] _, nV in
            let vc: ProfileImageViewController
            vc = ProfileImageViewController(viewType: .imageSetting, selectedProfileImageType: nV)
            vc.settingView.closure = { selectedProfileImageType in
                self?.settingView.profileImageType = selectedProfileImageType
            }
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        self.viewModel.profileNicknameCheckOut.bind { [weak self] _, nV in
            self?.settingView.nicknameTextFieldView.textFieldStateLabel.text = nV.rawValue
            self?.settingView.nicknameTextFieldView.textFieldStateLabel.textColor = nV.isValid ? UIColor.faValidLabel : UIColor.faInvalidLabel
            self?.settingView.completeButton.isEnabled = nV.isValid
            self?.settingView.completeButton.backgroundColor = nV.isValid ? UIColor.faValidButton : UIColor.faInvalidButton
        }
        self.viewModel.profileSaveOut.closure = { _, _ in
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
            window.rootViewController = MainTabBarController()
            window.makeKeyAndVisible()
        }
    }
}

extension NicknameViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if self.viewType == .nicknameSetting {
            self.viewModel.profileNicknameCheckIn.value = textField.text
        } else if self.viewType == .nicknameEditing {
            self.editingView.nicknameState = self.editingView.nicknameTextFieldView.nicknameTextField.text.checkNicknameValidation()
            self.navigationItem.rightBarButtonItem?.isEnabled = self.editingView.nicknameState == NicknameTextFieldState.ok
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.viewType == .nicknameSetting && self.viewModel.profileNicknameCheckOut.value.isValid {
            self.view.endEditing(true)
            return true
        } else if self.viewType == .nicknameEditing {
            self.editingView.nicknameState = textField.text.checkNicknameValidation()
            if self.editingView.nicknameState == .ok {
                self.view.endEditing(true)
            }
            return true
        } else {
            return false
        }
    }
}
