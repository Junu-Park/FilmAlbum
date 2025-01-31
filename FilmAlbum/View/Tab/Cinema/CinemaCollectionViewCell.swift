//
//  CinemaCollectionViewCell.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/29/25.
//

import UIKit

import SnapKit


final class CinemaCollectionViewCell: UICollectionViewCell {
    static let id: String = "CinemaCollectionViewCell"
    
    static let recentSearchTermCellHeight: CGFloat = 50
    
    private let recentSearchTermView: RecentSearchTermCollectionView = RecentSearchTermCollectionView(layout: UICollectionViewFlowLayout())
    
    private let todayMovieView: TodayMovieCollectionView = TodayMovieCollectionView(layout: UICollectionViewFlowLayout())
    
    var collectionCellType: CinemaCollectionCellType = .recentSearchTerm {
        didSet {
            if self.collectionCellType == .recentSearchTerm {
                self.recentSearchTermView.delegate = self
                self.recentSearchTermView.dataSource = self
                self.contentView.addSubview(recentSearchTermView)
                self.recentSearchTermView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            } else {
                self.todayMovieView.delegate = self
                self.todayMovieView.dataSource = self
                self.contentView.addSubview(todayMovieView)
                self.todayMovieView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
        }
    }
    
    var trendingDataList: [TrendingResult] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.recentSearchTermView.setNoRecentSearchTermLabelHidden()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CinemaCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.collectionCellType == .recentSearchTerm {
            return UserDataManager.getSetSearchTermList().count
        } else if self.collectionCellType == .todayMovie {
            return trendingDataList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.collectionCellType == .recentSearchTerm {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchTermCollectionViewCell.id, for: indexPath) as? RecentSearchTermCollectionViewCell {
                cell.titleLabel.text = UserDataManager.getSetSearchTermList()[indexPath.item]
                return cell
            } else {
                return UICollectionViewCell()
            }
        } else if self.collectionCellType == .todayMovie {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCollectionViewCell.id, for: indexPath) as? TodayMovieCollectionViewCell {
                cell.movieTitle.text = trendingDataList[indexPath.item].title
                cell.movieDescription.text = trendingDataList[indexPath.item].overview
                cell.moviePoster.kf.setImage(with: URL(string: TMDBAPI.imageBase + trendingDataList[indexPath.item].poster_path))
                return cell
            } else {
                return UICollectionViewCell()
            }
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.collectionCellType == .recentSearchTerm {
            return CGSize(width: 100, height: 40)
        } else if self.collectionCellType == .todayMovie {
            return CGSize(width: self.frame.width * 0.6, height: self.frame.height)
        } else {
            return CGSize()
        }
    }
}
