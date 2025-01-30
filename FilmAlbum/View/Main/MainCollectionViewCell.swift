//
//  MainCollectionViewCell.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/29/25.
//

import UIKit

import SnapKit

final class MainCollectionViewCell: UICollectionViewCell {
    static let id: String = "MainCollectionViewCell"
    
    static let recentSearchTermCellHeight: CGFloat = 50
    
    private let recentSearchTermView: RecentSearchTermCollectionView = RecentSearchTermCollectionView(layout: UICollectionViewFlowLayout())
    
    private let todayMovieView: TodayMovieCollectionView = TodayMovieCollectionView(layout: UICollectionViewFlowLayout())
    
    var collectionCellType: MainCollectionCellType = .recentSearchTerm {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.recentSearchTermView.setNoRecentSearchTermLabelHidden()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.collectionCellType == .recentSearchTerm {
            return UserDataManager.getSetSearchTermList().count
        } else if self.collectionCellType == .todayMovie {
            //TODO: 실제 데이터 연결
            return 10
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
