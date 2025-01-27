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
    
    private lazy var completeButton: RadiusBorderButton = {
        let btn = RadiusBorderButton(title: "완료", radius: 25)
        
        btn.isEnabled = self.nicknameState == NicknameTextFieldState.ok
        
        return btn
    }()
    
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
        self.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        
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
    
    @objc private func completeButtonTapped() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
        window.rootViewController = UINavigationController(rootViewController: MainViewController())
        window.makeKeyAndVisible()
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
