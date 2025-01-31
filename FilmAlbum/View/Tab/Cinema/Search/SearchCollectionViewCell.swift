//
//  SearchCollectionViewCell.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

import SnapKit

final class SearchCollectionViewCell: UICollectionViewCell {
    static let id: String = "SearchCollectionViewCell"
    
    let posterImageView: UIImageView = {
        let iv: UIImageView = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.faGray
        return iv
    }()
    
    let titleLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa16BoldFont
        lb.numberOfLines = 2
        return lb
    }()
    
    let dateLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa14Font
        lb.textColor = UIColor.faGray
        return lb
    }()
    
    let genre1Label: CustomInsetLabel = {
        let lb: CustomInsetLabel = CustomInsetLabel(inset: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        lb.textAlignment = .center
        lb.font = UIFont.fa14Font
        lb.backgroundColor = UIColor.faDarkGray
        lb.layer.cornerRadius = 5
        lb.clipsToBounds = true
        return lb
    }()
    
    let genre2Label: CustomInsetLabel = {
        let lb: CustomInsetLabel = CustomInsetLabel(inset: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        lb.textAlignment = .center
        lb.font = UIFont.fa14Font
        lb.backgroundColor = UIColor.faDarkGray
        lb.layer.cornerRadius = 5
        lb.clipsToBounds = true
        return lb
    }()
    
    lazy var likeButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.tintColor = UIColor.faAccent
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        btn.imageView?.contentMode = .scaleAspectFill
        btn.setImage(UIImage.faHeart, for: .normal)
        btn.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return btn
    }()
    
    private let separatorLine: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.faDarkGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.posterImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.genre1Label)
        self.contentView.addSubview(self.genre2Label)
        self.contentView.addSubview(self.likeButton)
        self.contentView.addSubview(self.separatorLine)
        
        self.posterImageView.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
            make.height.equalToSuperview().inset(16)
            make.width.equalTo(self.contentView.snp.width).multipliedBy(0.3)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.posterImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
        self.dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.posterImageView.snp.trailing).offset(16)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
        }
        self.genre1Label.snp.makeConstraints { make in
            make.leading.equalTo(self.posterImageView.snp.trailing).offset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        self.genre2Label.snp.makeConstraints { make in
            make.leading.equalTo(self.genre1Label.snp.trailing).offset(4)
            make.bottom.equalToSuperview().inset(16)
        }
        self.likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
        self.separatorLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
