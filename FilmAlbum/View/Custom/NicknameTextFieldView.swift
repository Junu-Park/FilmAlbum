//
//  NicknameTextFieldView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/26/25.
//

import UIKit

import SnapKit

final class NicknameTextFieldView: UIView {

    private let nicknameTextField: UITextField = {
        let tf: UITextField = UITextField()
        
        tf.attributedText = NSAttributedString(string: "", attributes: [.font: UIFont.fa16Font])
        tf.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요.", attributes: [.foregroundColor: UIColor.faGray, .font: UIFont.fa16Font])
        tf.textColor = UIColor.faWhite
        tf.tintColor = UIColor.faWhite
        
        return tf
    }()
    
    private let textFieldUnderlineView: UIView = {
        let view: UIView = UIView()
        
        view.backgroundColor = UIColor.faWhite
        
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(nicknameTextField)
        self.addSubview(textFieldUnderlineView)
        
        self.nicknameTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        self.textFieldUnderlineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
