//
//  TodayMovieCollectionViewCell.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/28/25.
//

import UIKit

final class TodayMovieCollectionViewCell: UICollectionViewCell {
    static let id: String = "TodayMovieCollectionViewCell"
    
    let moviePoster: UIImageView = {
        let iv: UIImageView = UIImageView()
        iv.backgroundColor = UIColor.faGray
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        return iv
    }()
    
    let movieTitle: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa16BoldFont
        lb.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return lb
    }()
    
    let movieDescription: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa12Font
        lb.numberOfLines = 2
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
        btn.addTarget(self, action: #selector(self.likeButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    var delegate: LikeButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(moviePoster)
        self.contentView.addSubview(movieTitle)
        self.contentView.addSubview(movieDescription)
        self.contentView.addSubview(likeButton)
        
        self.moviePoster.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(self.frame.height * 0.8)
        }
        self.movieTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.top.equalTo(self.moviePoster.snp.bottom).offset(4)
        }
        self.likeButton.snp.makeConstraints { make in
            make.leading.equalTo(self.movieTitle.snp.trailing)
            make.trailing.equalToSuperview().inset(4)
            make.top.equalTo(self.moviePoster.snp.bottom).offset(4)
        }
        self.movieDescription.snp.makeConstraints { make in
            make.top.equalTo(self.movieTitle.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().offset(4)
        }
    }
    
    @objc private func likeButtonTapped() {
        delegate?.likeButtonTapped(index: self.tag)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
