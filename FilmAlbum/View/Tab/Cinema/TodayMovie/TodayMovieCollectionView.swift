//
//  TodayMovieCollectionView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/29/25.
//

import UIKit

final class TodayMovieCollectionView: UICollectionView {
    
    init(layout: UICollectionViewFlowLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .horizontal
        self.collectionViewLayout = layout
        self.register(TodayMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodayMovieCollectionViewCell.id)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
