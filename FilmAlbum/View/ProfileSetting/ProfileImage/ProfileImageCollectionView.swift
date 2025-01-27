//
//  ProfileImageCollectionView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/27/25.
//

import UIKit

class ProfileImageCollectionView: UICollectionView {
    
    init(layout: UICollectionViewFlowLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        self.backgroundColor = UIColor.clear
        self.collectionViewLayout = layout
        self.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
