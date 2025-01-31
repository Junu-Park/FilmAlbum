//
//  CinemaViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

import Kingfisher
import SnapKit

enum CinemaCollectionCellType: String, CaseIterable {
    case recentSearchTerm = "최근검색어"
    case todayMovie = "오늘의 영화"
}

final class CinemaViewController: CustomBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let profileBannerView: ProfileBannerView = ProfileBannerView()
    
    private let cinemaCollectionView: CinemaCollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let cv: CinemaCollectionView = CinemaCollectionView(layout: layout)
        return cv
    }()
    
    private var trendingDataList: [TrendingResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.requestTMDB(type: TMDBAPI.trending(params: TrendingRequest())) { (response: TrendingResponse) in
            self.trendingDataList = response.results
            self.cinemaCollectionView.reloadSections([1])
        }
        self.configureNavigationItem()
        self.profileBannerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.profileBannerTapped)))
        self.configureConnectionCollectionView()
        
        self.view.addSubview(profileBannerView)
        self.view.addSubview(cinemaCollectionView)
        
        self.profileBannerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(150)
        }
        self.cinemaCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.profileBannerView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func configureNavigationItem() {
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage.faMagnifyingglass, style: .plain, target: self, action: #selector(self.searchButtonTapped)), animated: true)
    }
    
    // TODO: 찾기 화면으로 이동 로직 추가
    @objc private func searchButtonTapped() {
        UserDataManager.resetUserData()
    }
    
    @objc private func profileBannerTapped() {
        let nc = UINavigationController(rootViewController: NicknameViewController(viewType: .nicknameEditing))
        nc.sheetPresentationController?.prefersGrabberVisible = true
        self.present(nc, animated: true)
    }
}

// CollectionView Header
extension CinemaViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CinemaCollectionCellType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CinemaCollectionReusableHeaderView.id, for: indexPath) as? CinemaCollectionReusableHeaderView {
            if indexPath.section == 0 {
                header.headerType = .recentSearchTerm
                header.allDeleteButtonClosure = {
                    UserDataManager.resetSearchTermList()
                    self.cinemaCollectionView.reloadSections(IndexSet(integer: 0))
                }
            } else {
                header.headerType = .todayMovie
            }
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: CinemaCollectionReusableHeaderView.height)
    }
}

// CollectionView Cell
extension CinemaViewController {
    
    private func configureConnectionCollectionView() {
        self.cinemaCollectionView.delegate = self
        self.cinemaCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CinemaCollectionViewCell.id, for: indexPath) as? CinemaCollectionViewCell {
            
            if indexPath.section == 0 {
                cell.collectionCellType = .recentSearchTerm
            } else {
                cell.collectionCellType = .todayMovie
                cell.trendingDataList = self.trendingDataList
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGSize = CGSize(width: collectionView.frame.width, height: .zero)
        if indexPath.section == 0 {
            size.height = CinemaCollectionViewCell.recentSearchTermCellHeight
        } else {
            size.height = collectionView.frame.height - CinemaCollectionViewCell.recentSearchTermCellHeight - (CinemaCollectionReusableHeaderView.height * CGFloat(CinemaCollectionCellType.allCases.count))
        }
        return size
    }
}
