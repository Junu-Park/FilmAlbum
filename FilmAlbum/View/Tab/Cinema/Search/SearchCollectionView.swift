//
//  SearchCollectionView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

import SnapKit

final class SearchCollectionView: UICollectionView {
    
    private let noSearchDataLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.isHidden = true
        lb.font = UIFont.fa16BoldFont
        lb.text = "원하는 검색결과를 찾지 못했습니다."
        return lb
    }()
    
    init(layout: UICollectionViewFlowLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 1
        self.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
        self.collectionViewLayout = layout
        
        self.addSubview(self.noSearchDataLabel)
        
        self.noSearchDataLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func checkNoSearchData(count: Int) {
        if count > 0 {
            noSearchDataLabel.isHidden = true
        } else {
            noSearchDataLabel.isHidden = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
