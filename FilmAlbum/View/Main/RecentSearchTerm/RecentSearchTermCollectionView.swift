//
//  RecentSearchTermCollectionView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/29/25.
//

import UIKit

import SnapKit

final class RecentSearchTermCollectionView: UICollectionView {

    private let noRecentSearchTermLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa12BoldFont
        lb.textColor = UIColor.faGray
        lb.text = "최근 검색어 내역이 없습니다."
        return lb
    }()
    
    init(layout: UICollectionViewFlowLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .horizontal
        self.collectionViewLayout = layout
        self.register(RecentSearchTermCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchTermCollectionViewCell.id)
        
        self.addSubview(self.noRecentSearchTermLabel)
        
        self.noRecentSearchTermLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setNoRecentSearchTermLabelHidden() {
        self.noRecentSearchTermLabel.isHidden = !UserDataManager.getSetSearchTermList().isEmpty
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
