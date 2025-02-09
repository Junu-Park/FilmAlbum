//
//  MBTIButton.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/9/25.
//

import UIKit

final class MBTIButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        var configuration: UIButton.Configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("", attributes: AttributeContainer([.font: UIFont.fa14BoldFont]))
        self.configuration = configuration
        self.setUnselectedMBTI()
        self.layer.cornerRadius = 25
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUnselectedMBTI() {
        self.setTitleColor(UIColor.faGray, for: [])
        self.layer.borderColor = UIColor.faGray.cgColor
        self.layer.borderWidth = 2
        self.backgroundColor = UIColor.clear
    }
    
    func setSelectedMBTI() {
        self.setTitleColor(UIColor.faWhite, for: [])
        self.layer.borderColor = UIColor.faValidButton.cgColor
        self.backgroundColor = UIColor.faValidButton
    }
}
