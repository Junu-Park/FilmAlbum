//
//  CustomInsetLabel.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

final class CustomInsetLabel: UILabel {
    
    private var inset: UIEdgeInsets = UIEdgeInsets.zero
    
    init(inset: UIEdgeInsets = UIEdgeInsets.zero) {
        super.init(frame: .zero)
        self.inset = inset
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.inset))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        
        contentSize.height += inset.top + inset.bottom
        contentSize.width += inset.left + inset.right
        
        return contentSize
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
