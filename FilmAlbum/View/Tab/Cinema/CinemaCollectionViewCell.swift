//
//  CinemaCollectionViewCell.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/29/25.
//

import UIKit

import SnapKit

protocol LikeButtonDelegate: AnyObject {
    func likeButtonTapped(index: Int)
}

final class CinemaCollectionViewCell: UICollectionViewCell {
    static let id: String = "CinemaCollectionViewCell"
    
    static let recentSearchTermCellHeight: CGFloat = 50
    
    private let recentSearchTermView: RecentSearchTermCollectionView = RecentSearchTermCollectionView(layout: UICollectionViewFlowLayout())
    
    private let todayMovieView: TodayMovieCollectionView = TodayMovieCollectionView(layout: UICollectionViewFlowLayout())
    
    var searchDelegate: SearchCollectionViewButtonDelegate?
    var todayMovieDelegate: TodayMovieCollectionViewDelegate?
    
    var collectionCellType: CinemaCollectionCellType = .recentSearchTerm {
        didSet {
            if self.collectionCellType == .recentSearchTerm {
                self.recentSearchTermView.tag = 1
                self.recentSearchTermView.delegate = self
                self.recentSearchTermView.dataSource = self
                self.contentView.addSubview(recentSearchTermView)
                self.recentSearchTermView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            } else {
                self.todayMovieView.tag = 2
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedLikeButtonTappedNotification), name: NSNotification.Name("LikeButtonTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedSearchBarEnterTappedNotification), name: NSNotification.Name("searchBarEnterTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedSearchBarEnterTappedNotification), name: NSNotification.Name("deleteButtonTapped"), object: nil)
    }
    
    @objc private func receivedLikeButtonTappedNotification(value: NSNotification) {
        if let info = value.userInfo?["isSearch"] as? Bool, info {
            self.todayMovieView.reloadData()
        } else if let info = value.userInfo?["isSearchDetail"] as? Bool, info {
            self.todayMovieView.reloadData()
        }
    }
    
    @objc private func receivedSearchBarEnterTappedNotification() {
        self.recentSearchTermView.setNoRecentSearchTermLabelHidden()
        self.recentSearchTermView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CinemaCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return UserDataManager.getSetSearchTermList().count
        } else if collectionView.tag == 2 {
            return trendingDataList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchTermCollectionViewCell.id, for: indexPath) as? RecentSearchTermCollectionViewCell {
                cell.titleLabel.text = UserDataManager.getSetSearchTermList()[indexPath.item]
                
                cell.titleLabel.tag = indexPath.item
                cell.titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.searchTermTapped)))
                cell.removeButton.tag = indexPath.item
                cell.removeButton.addTarget(self, action: #selector(self.searchTermDeleteTapped), for: .touchUpInside)
                return cell
            } else {
                return UICollectionViewCell()
            }
        } else if collectionView.tag == 2 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCollectionViewCell.id, for: indexPath) as? TodayMovieCollectionViewCell {
                if UserDataManager.likeMovieList.contains(self.trendingDataList[indexPath.item].id) {
                    cell.likeButton.setImage(UIImage.faHeartFill, for: .normal)
                } else {
                    cell.likeButton.setImage(UIImage.faHeart, for: .normal)
                }
                cell.delegate = self
                cell.tag = indexPath.item
                cell.movieTitle.text = trendingDataList[indexPath.item].title
                cell.movieDescription.text = trendingDataList[indexPath.item].overview
                cell.moviePoster.kf.setImage(with: URL(string: TMDBAPI.image400Base + trendingDataList[indexPath.item].poster_path))
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 2 {
            
            // TODO: TrendingResult과 SearchResult 통합하기
            let data: TrendingResult = self.trendingDataList[indexPath.row]
            let newData: SearchResult = SearchResult(id: data.id, backdrop_path: data.backdrop_path, title: data.title, overview: data.overview, poster_path: data.poster_path, genre_ids: data.genre_ids, release_date: data.release_date, vote_average: data.vote_average)
            self.todayMovieDelegate?.todayMovieTapped(data: newData)
        }
    }
    
    @objc func searchTermTapped(_ sender: UITapGestureRecognizer) {
        if let index = sender.view?.tag {
            self.searchDelegate?.searchTermTapped(searchTerm: UserDataManager.getSetSearchTermList()[index])
        }
    }
    
    @objc func searchTermDeleteTapped(_ sender: UIButton) {
        self.searchDelegate?.searchTermDeleteTapped(index: sender.tag)
    }
}

extension CinemaCollectionViewCell: LikeButtonDelegate {
    func likeButtonTapped(index: Int) {
        var list = UserDataManager.likeMovieList
        if let order = list.firstIndex(of: self.trendingDataList[index].id) {
            list.remove(at: order)
        } else {
            list.append(self.trendingDataList[index].id)
        }
        UserDataManager.likeMovieList = list
        NotificationCenter.default.post(name: NSNotification.Name("LikeButtonTapped"), object: nil)
        UIView.performWithoutAnimation {
            self.todayMovieView.reloadItems(at: [IndexPath(item: index, section: 0)])
        }
    }
}
