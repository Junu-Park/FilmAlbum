//
//  MainCollectionView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/28/25.
//

import UIKit

final class MainCollectionView: UICollectionView {

    init(layout: UICollectionViewFlowLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.isScrollEnabled = false
        self.collectionViewLayout = layout
        
        self.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
        self.register(RecentSearchTermCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchTermCollectionViewCell.id)
        self.register(TodayMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodayMovieCollectionViewCell.id)
        self.register(MainCollectionReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainCollectionReusableHeaderView.id)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
