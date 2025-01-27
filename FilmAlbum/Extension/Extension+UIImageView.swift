//
//  Extension+UIImageView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/26/25.
//

import UIKit

extension UIImageView {
    func selectedProfileImage() {
        self.layer.borderColor = UIColor.accent.cgColor
        self.layer.borderWidth = 3
    }
    
    func unselectedProfileImage() {
        self.alpha = 0.5
        self.layer.borderColor = UIColor.faGray.cgColor
        self.layer.borderWidth = 1
    }
}
