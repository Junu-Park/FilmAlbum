//
//  BackdropCollectionViewCell.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/1/25.
//

import UIKit

final class BackdropCollectionViewCell: UICollectionViewCell {
    static let id: String = "BackdropCollectionViewCell"
    
    let backdropImageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.backdropImageView)
        
        self.backdropImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
