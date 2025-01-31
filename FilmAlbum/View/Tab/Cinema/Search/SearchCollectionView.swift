//
//  SearchCollectionView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

final class SearchCollectionView: UICollectionView {
    
    init(layout: UICollectionViewFlowLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 1
        self.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
        self.collectionViewLayout = layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
