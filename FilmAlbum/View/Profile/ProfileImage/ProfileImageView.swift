//
//  ProfileImageView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/25/25.
//

import UIKit

import SnapKit

final class ProfileImageView: UIView {
    
    private lazy var profileImage: UIImageView = {
        let iv: UIImageView = UIImageView()
        
        iv.backgroundColor = UIColor.clear
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage.getProfileImageWithName(name: self.profileImageType.imageName)
        if self.isSelected {
            iv.selectedProfileImage()
        } else {
            iv.unselectedProfileImage()
        }
        
        return iv
    }()
    
    private lazy var cameraImage: UIButton = {
        let btn: UIButton = UIButton()
        
        btn.isUserInteractionEnabled = false
        btn.imageView?.backgroundColor = UIColor.clear
        btn.clipsToBounds = true
        btn.backgroundColor = UIColor.faAccent
        btn.tintColor = UIColor.faWhite
        btn.setImage(.faCameraFill, for: .normal)
        if showCamera {
            btn.isHidden = false
        } else {
            btn.isHidden = true
        }
        
        return btn
    }()
    
    var profileImageType: ProfileImageType! {
        didSet {
            self.profileImage.image = UIImage.getProfileImageWithName(name: self.profileImageType.imageName)
        }
    }
    
    var isSelected: Bool = false {
        didSet {
            if isSelected {
                profileImage.selectedProfileImage()
            } else {
                profileImage.unselectedProfileImage()
            }
        }
    }
    
    var showCamera: Bool = false {
        didSet {
            if showCamera {
                self.cameraImage.isHidden = false
            } else {
                self.cameraImage.isHidden = true
            }
        }
    }
    
    var canTap: Bool = false {
        didSet {
            if canTap {
                self.isUserInteractionEnabled = true
            } else {
                self.isUserInteractionEnabled = false
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        self.cameraImage.layer.cornerRadius = self.cameraImage.frame.width / 2
    }
    
    init(profileImageType: ProfileImageType, isSelected: Bool = false, showCamera: Bool = false, canTap: Bool = false) {
        super.init(frame: .zero)
        
        self.profileImageType = profileImageType
        self.isSelected = isSelected
        self.showCamera = showCamera
        self.canTap = canTap
        
        self.addSubview(self.profileImage)
        self.addSubview(self.cameraImage)
        
        self.profileImage.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        self.cameraImage.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
            make.height.equalTo(self.cameraImage.snp.width)
            make.right.bottom.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
