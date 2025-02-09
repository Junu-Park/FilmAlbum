//
//  MBTICollectionViewCell.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/9/25.
//

import UIKit

import SnapKit

final class MBTICollectionViewCell: UICollectionViewCell {
    static let id: String = "MBTICollectionViewCell"
    
    let firstButton: MBTIButton = MBTIButton()
    let secondButton: MBTIButton = MBTIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.firstButton)
        self.contentView.addSubview(self.secondButton)
        
        self.firstButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(self.firstButton.snp.width)
        }
        self.secondButton.snp.makeConstraints { make in
            make.top.equalTo(self.firstButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(self.secondButton.snp.width)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
