//
//  RadiusBorderButton.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

class RadiusBorderButton: UIButton {
    
    init(title: String, radius: CGFloat) {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.accent.cgColor
        
        let attributedNormalString: NSAttributedString = NSAttributedString(string: title, attributes: [.font: UIFont.fa14BoldFont, .foregroundColor: UIColor.accent])
        self.setAttributedTitle(attributedNormalString, for: .normal)
        
        let attributedHighlightString: NSAttributedString = NSAttributedString(string: title, attributes: [.font: UIFont.fa14BoldFont, .foregroundColor: UIColor.faLightGray])
        self.setAttributedTitle(attributedHighlightString, for: .highlighted)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
