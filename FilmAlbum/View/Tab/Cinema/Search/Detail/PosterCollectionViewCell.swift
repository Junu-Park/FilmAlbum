//
//  PosterCollectionViewCell.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/1/25.
//

import UIKit

import SnapKit

final class PosterCollectionViewCell: UICollectionViewCell {
    static let id: String = "PosterCollectionViewCell"
    
    let posterImageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.posterImageView)
        
        self.posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
