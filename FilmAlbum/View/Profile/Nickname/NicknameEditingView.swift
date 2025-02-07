//
//  NicknameEditingView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/26/25.
//

import UIKit

import SnapKit

final class NicknameEditingView: UIView {
    
    lazy var profileImageView: ProfileImageView = ProfileImageView(profileImageType: self.profileImageType, isSelected: true, showCamera: true, canTap: true)
    
    let nicknameTextFieldView: NicknameTextFieldView = NicknameTextFieldView()
    
    var profileImageType: ProfileImageType! {
        didSet {
            self.profileImageView.profileImageType = self.profileImageType
        }
    }
    
    var nicknameState: NicknameTextFieldState! {
        didSet {
            self.nicknameTextFieldView.textFieldStateLabel.text = self.nicknameState.rawValue
        }
    }
    
    init(profileImageType: ProfileImageType) {
        super.init(frame: .zero)
        
        self.profileImageType = profileImageType
        self.nicknameTextFieldView.nicknameTextField.text = UserDataManager.getSetNickname()
        self.nicknameState = self.nicknameTextFieldView.nicknameTextField.text.checkNicknameValidation()
        
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
