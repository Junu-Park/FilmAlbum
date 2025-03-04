//
//  CinemaCollectionView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/28/25.
//

import UIKit

final class CinemaCollectionView: UICollectionView {

    init(layout: UICollectionViewFlowLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.isScrollEnabled = false
        self.collectionViewLayout = layout
        
        self.register(CinemaCollectionViewCell.self, forCellWithReuseIdentifier: CinemaCollectionViewCell.id)
        self.register(CinemaCollectionReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CinemaCollectionReusableHeaderView.id)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
