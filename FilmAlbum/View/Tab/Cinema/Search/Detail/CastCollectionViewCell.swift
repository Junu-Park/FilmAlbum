//
//  CastCollectionViewCell.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/1/25.
//

import UIKit

import SnapKit

final class CastCollectionViewCell: UICollectionViewCell {
    static let id: String = "CastCollectionViewCell"
    
    lazy var castImage: UIImageView = {
        let iv: UIImageView = UIImageView()
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.faGray
        DispatchQueue.main.async {
            self.castImage.layer.cornerRadius = self.castImage.frame.width / 2
        }
        return iv
    }()
    
    let castKoName: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa13BoldFont
        return lb
    }()
    
    let castCharacterName: UILabel = {
        let lb: UILabel = UILabel()
        lb.textColor = UIColor.faLightGray
        lb.font = UIFont.fa12Font
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.castImage)
        self.contentView.addSubview(self.castKoName)
        self.contentView.addSubview(self.castCharacterName)
        
        self.castImage.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.leading.equalToSuperview()
        }
        self.castKoName.snp.makeConstraints { make in
            make.leading.equalTo(self.castImage.snp.trailing).offset(8)
            make.centerY.equalTo(self.castImage.snp.centerY).offset(-8)
            make.trailing.equalToSuperview()
        }
        self.castCharacterName.snp.makeConstraints { make in
            make.leading.equalTo(self.castImage.snp.trailing).offset(8)
            make.centerY.equalTo(self.castImage.snp.centerY).offset(8)
            make.trailing.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
