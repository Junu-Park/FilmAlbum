//
//  NicknameSettingView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/26/25.
//

import UIKit

import SnapKit

final class NicknameSettingView: UIView {

    lazy var profileImageView: ProfileImageView = ProfileImageView(profileImageType: self.profileImageType, isSelected: true, showCamera: true, canTap: true)
    
    let nicknameTextFieldView: NicknameTextFieldView = NicknameTextFieldView()
    
    let completeButton: RadiusBorderButton = RadiusBorderButton(title: "완료", radius: 25, isBorder: false)
    
    var profileImageType: ProfileImageType! {
        didSet {
            self.profileImageView.profileImageType = self.profileImageType
        }
    }
    
    private var nicknameState: NicknameTextFieldState! {
        didSet {
            self.nicknameTextFieldView.textFieldStateLabel.text = self.nicknameState.rawValue
            self.completeButton.isEnabled = self.nicknameState == NicknameTextFieldState.ok
        }
    }
    
    init(profileImageType: ProfileImageType) {
        super.init(frame: .zero)
        
        self.profileImageType = profileImageType
        self.nicknameTextFieldView.nicknameTextField.text = UserDataManager.getSetNickname()
        self.nicknameState = self.nicknameTextFieldView.nicknameTextField.text.checkNicknameValidation()
        
        self.addSubview(self.profileImageView)
        self.addSubview(self.nicknameTextFieldView)
        self.addSubview(self.completeButton)
        
        self.profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.size.equalTo(self.snp.width).multipliedBy(0.3)
            make.centerX.equalToSuperview()
        }
        self.nicknameTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        self.completeButton.snp.makeConstraints { make in
            make.top.equalTo(self.nicknameTextFieldView.textFieldStateLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
