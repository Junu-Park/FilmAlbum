//
//  CastCollectionView.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/1/25.
//

import UIKit

final class CastCollectionView: UICollectionView {
    
    init(layout: UICollectionViewFlowLayout) {
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        super.init(frame: .zero, collectionViewLayout: layout)
        self.collectionViewLayout = layout
        self.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.id)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
