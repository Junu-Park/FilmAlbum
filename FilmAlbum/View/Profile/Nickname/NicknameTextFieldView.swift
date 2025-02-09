//
//  NicknameTextFieldView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/26/25.
//

import UIKit

import SnapKit

enum NicknameTextFieldState: String {
    case ok = "사용할 수 있는 닉네임이에요"
    case charCountError = "2글자 이상 10글자 미만으로 설정해주세요"
    case specialCharError = "닉네임에 @, #, $, % 는 포함할 수 없어요"
    case numberCharError = "닉네임에 숫자는 포함할 수 없어요"
}

final class NicknameTextFieldView: UIView {

    let nicknameTextField: UITextField = {
        let tf: UITextField = UITextField()
        
        tf.attributedText = NSAttributedString(string: "", attributes: [.font: UIFont.fa16Font])
        tf.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요 :)", attributes: [.foregroundColor: UIColor.faGray, .font: UIFont.fa16Font])
        tf.textColor = UIColor.faWhite
        tf.tintColor = UIColor.faWhite
        
        return tf
    }()
    
    private let textFieldUnderlineView: UIView = {
        let view: UIView = UIView()
        
        view.backgroundColor = UIColor.faWhite
        
        return view
    }()
    
    lazy var textFieldStateLabel: UILabel = {
        let lb: UILabel = UILabel()
        
        lb.text = nicknameTextField.text.checkNicknameValidation().rawValue
        lb.font = UIFont.fa12Font
        lb.textColor = UIColor.faAccent
        
        return lb
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(nicknameTextField)
        self.addSubview(textFieldUnderlineView)
        self.addSubview(textFieldStateLabel)
        
        self.nicknameTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        self.textFieldUnderlineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        self.textFieldStateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.textFieldUnderlineView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
