//
//  NicknameSettingView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/26/25.
//

import UIKit

import SnapKit

final class NicknameSettingView: CustomBaseView {

    lazy var profileImageView: ProfileImageView = ProfileImageView(profileImageType: self.profileImageType, isSelected: true, showCamera: true, canTap: true)
    
    let nicknameTextFieldView: NicknameTextFieldView = NicknameTextFieldView()
    
    let completeButton: RadiusBorderButton = {
        let btn: RadiusBorderButton = RadiusBorderButton(title: "완료", radius: 25, isBorder: false)
        btn.isEnabled = false
        btn.backgroundColor = UIColor.faInvalidButton
        return btn
    }()
    
    let mbtiTitleLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa14BoldFont
        lb.textColor = UIColor.faWhite
        lb.text = "MBTI"
        return lb
    }()
    
    let mbtiCollectionView: MBTICollectionView = MBTICollectionView(layout: UICollectionViewFlowLayout())
    
    var profileImageType: ProfileImageType {
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
        self.profileImageType = profileImageType
        
        super.init()
        
        self.backgroundColor = UIColor.faBlack
        self.nicknameTextFieldView.nicknameTextField.text = UserDataManager.getSetNickname()
        self.nicknameState = self.nicknameTextFieldView.nicknameTextField.text.checkNicknameValidation()
        
        self.addSubview(self.profileImageView)
        self.addSubview(self.nicknameTextFieldView)
        self.addSubview(self.mbtiCollectionView)
        self.addSubview(self.completeButton)
        self.addSubview(self.mbtiTitleLabel)
        
        self.profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.size.equalTo(self.snp.width).multipliedBy(0.3)
            make.centerX.equalToSuperview()
        }
        self.nicknameTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        self.mbtiTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nicknameTextFieldView.snp.bottom).offset(64)
            make.leading.equalToSuperview().inset(16)
        }
        self.mbtiCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.nicknameTextFieldView.snp.bottom).offset(64)
            make.width.equalTo(248)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(116)
        }
        self.completeButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
    }
}
