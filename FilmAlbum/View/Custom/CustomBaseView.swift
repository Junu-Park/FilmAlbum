//
//  CustomBaseView.swift
//  FilmAlbum
//
//  Created by 박준우 on 3/2/25.
//

import UIKit

class CustomBaseView: UIView {
    
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
