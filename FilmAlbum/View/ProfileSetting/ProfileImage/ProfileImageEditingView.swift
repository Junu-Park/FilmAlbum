//
//  ProfileImageEditingView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/27/25.
//

import UIKit

class ProfileImageEditingView: UIView {
    
    private lazy var selectedProfileImage: ProfileImageView = ProfileImageView(profileImageType: self.selectedProfileImageType, isSelected: true, showCamera: true, canTap: false)
    
    private lazy var profileImageCollectionView: ProfileImageCollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.minimumLineSpacing = 16
        let sideSpacing: CGFloat = 24
        let itemSpacing: CGFloat = 16
        let width: Int = Int(UIScreen.main.bounds.width - (sideSpacing * 2) - (itemSpacing * 3)) / 4
        layout.itemSize = CGSize(width: width, height: width)
        
        let cv: ProfileImageCollectionView = ProfileImageCollectionView(layout: layout)
        return cv
    }()
    
    var selectedProfileImageType: ProfileImage! {
        didSet {
            self.selectedProfileImage.profileImageType = self.selectedProfileImageType
            self.profileImageCollectionView.reloadData()
            closure?(self.selectedProfileImageType)
        }
    }
    
    private let profileImageList: [ProfileImage] = ProfileImage.allCases
    
    var closure: ((ProfileImage) -> ())?
    
    init(selectedProfileImageType: ProfileImage) {
        super.init(frame: .zero)
        
        self.configureCollectionViewConnection()
        self.selectedProfileImageType = selectedProfileImageType
        
        self.addSubview(selectedProfileImage)
        self.addSubview(profileImageCollectionView)
        
        self.selectedProfileImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.size.equalTo(self.snp.width).multipliedBy(0.3)
            make.centerX.equalToSuperview()
        }
        self.profileImageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.selectedProfileImage.snp.bottom).offset(64)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileImageEditingView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionViewConnection() {
        self.profileImageCollectionView.delegate = self
        self.profileImageCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as? ProfileImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.profileImageView.profileImageType = self.profileImageList[indexPath.item]
        
        if cell.profileImageView.profileImageType == self.selectedProfileImageType {
            cell.profileImageView.isSelected = true
        } else {
            cell.profileImageView.isSelected = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectedProfileImageType != self.profileImageList[indexPath.item] {
            self.selectedProfileImageType = self.profileImageList[indexPath.item]
        }
    }
}
