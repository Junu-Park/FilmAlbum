//
//  MBTICollectionView.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/9/25.
//

import UIKit

final class MBTICollectionView: UICollectionView {
    
    init(layout: UICollectionViewFlowLayout) {
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 50, height: 116)
        super.init(frame: .zero, collectionViewLayout: layout)
        self.register(MBTICollectionViewCell.self, forCellWithReuseIdentifier: MBTICollectionViewCell.id)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
