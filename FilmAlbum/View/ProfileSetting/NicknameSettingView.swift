//
//  NicknameSettingView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/26/25.
//

import UIKit

import SnapKit

final class NicknameSettingView: UIView {

    private lazy var profileImageView: ProfileImageView = ProfileImageView(profileImageType: self.profileImageType, isSelected: true, showCamera: true, canTap: true)
    
    private let nicknameTextFieldView: NicknameTextFieldView = NicknameTextFieldView()
    
    private var profileImageType: ProfileImage!
    
    private var nicknameState: NicknameTextFieldState! {
        didSet {
            self.nicknameTextFieldView.textFieldStateLabel.text = self.nicknameState.rawValue
            self.completeButton.isEnabled = self.nicknameState == NicknameTextFieldState.ok
        }
    }
    
    init(profileImageType: ProfileImage) {
        super.init(frame: .zero)
        
        self.profileImageType = profileImageType
        self.nicknameState = self.nicknameTextFieldView.nicknameTextField.text.checkNicknameValidation()
        self.nicknameTextFieldView.nicknameTextField.delegate = self
        
        self.addSubview(self.profileImageView)
        self.addSubview(self.nicknameTextFieldView)
        
        self.profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.size.equalTo(self.snp.width).multipliedBy(0.3)
            make.centerX.equalToSuperview()
        }
        self.nicknameTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NicknameSettingView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.nicknameState = textField.text.checkNicknameValidation()
    }
}
