//
//  ProfileBannerView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/28/25.
//

import UIKit

import SnapKit

final class ProfileBannerView: UIView {
    
    private let profileImageView: ProfileImageView = ProfileImageView(profileImageType: UserDataManager.getSetProfileImage(), isSelected: true)
    
    private let nicknameLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.text = UserDataManager.getSetNickname()
        lb.font = UIFont.fa16BoldFont
        return lb
    }()
    
    private let createdDateLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.textColor = UIColor.faGray
        lb.text = UserDataManager.getSetCreatedDateString()
        lb.font = UIFont.fa12BoldFont
        return lb
    }()
    
    private let chevronRightImage: UIImageView = {
        let iv: UIImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.tintColor = UIColor.faGray
        return iv
    }()
    
    private let movieCountLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.text = "\(UserDataManager.getSetLikeMovieList().count) 개의 무비박스 보관중"
        lb.clipsToBounds = true
        lb.layer.cornerRadius = 10
        lb.font = UIFont.fa14BoldFont
        lb.backgroundColor = UIColor.faDarkAccent
        lb.textAlignment = .center
        return lb
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.faDarkGray
        self.layer.cornerRadius = 15
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedProfileEditingNotification), name: NSNotification.Name("ProfileEditing"), object: nil)
        
        self.addSubview(self.profileImageView)
        self.addSubview(self.nicknameLabel)
        self.addSubview(self.createdDateLabel)
        self.addSubview(self.movieCountLabel)
        self.addSubview(self.chevronRightImage)
        
        self.profileImageView.snp.makeConstraints { make in
            make.size.equalTo(self.snp.height).multipliedBy(0.4)
            make.top.leading.equalToSuperview().offset(16)
        }
        self.nicknameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.profileImageView.snp.centerY).offset(-4)
            make.leading.equalTo(self.profileImageView.snp.trailing).offset(16)
        }
        self.createdDateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.centerY).offset(4)
            make.leading.equalTo(self.profileImageView.snp.trailing).offset(16)
        }
        self.chevronRightImage.snp.makeConstraints { make in
            make.centerY.equalTo(self.profileImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
        }
        self.movieCountLabel.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalToSuperview().inset(16)
        }
    }
    
    @objc private func receivedProfileEditingNotification() {
        self.profileImageView.profileImageType = UserDataManager.getSetProfileImage()
        self.nicknameLabel.text = UserDataManager.getSetNickname()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
