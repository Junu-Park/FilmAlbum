//
//  ProfileImageCollectionViewCell.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/27/25.
//

import UIKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    static let id: String = "ProfileImageCollectionViewCell"
    
    let profileImageView: ProfileImageView = ProfileImageView(profileImageType: ProfileImage.profile1, isSelected: false, showCamera: false, canTap: false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(profileImageView)
        
        self.profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
