//
//  RecentSearchTermCollectionViewCell.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/28/25.
//

import UIKit

import SnapKit

final class RecentSearchTermCollectionViewCell: UICollectionViewCell {
    
    static let id: String = "RecentSearchTermCollectionViewCell"
    
    let titleLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.isUserInteractionEnabled = true
        lb.font = UIFont.fa14Font
        lb.textColor = UIColor.faBlack
        lb.textAlignment = .center
        lb.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return lb
    }()
    
    private let removeButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setImage(UIImage.faXmark, for: .normal)
        btn.tintColor = UIColor.faBlack
        btn.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.faLightGray
        self.layer.cornerRadius = 20
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(removeButton)
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
        }
        self.removeButton.snp.makeConstraints { make in
            make.leading.equalTo(self.titleLabel.snp.trailing)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
