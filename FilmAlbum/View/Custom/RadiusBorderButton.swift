//
//  RadiusBorderButton.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

final class RadiusBorderButton: UIButton {
    
    init(title: String, radius: CGFloat, isBorder: Bool) {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = radius
        if isBorder {
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.faAccent.cgColor
        }
        self.titleLabel?.textColor = UIColor.faGray
        let attributedNormalString: NSAttributedString = NSAttributedString(string: title, attributes: [.font: UIFont.fa14BoldFont, .foregroundColor: UIColor.faWhite])
        self.setAttributedTitle(attributedNormalString, for: .normal)
        
        let attributedHighlightString: NSAttributedString = NSAttributedString(string: title, attributes: [.font: UIFont.fa14BoldFont, .foregroundColor: UIColor.faLightGray])
        self.setAttributedTitle(attributedHighlightString, for: .highlighted)
        
        let attributedDisableString: NSAttributedString = NSAttributedString(string: title, attributes: [.font: UIFont.fa14BoldFont, .foregroundColor: UIColor.faWhite])
        self.setAttributedTitle(attributedDisableString, for: .disabled)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
