//
//  MainViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

import Kingfisher
import SnapKit

enum MainCollectionCellType: String, CaseIterable {
    case recentSearchTerm = "최근검색어"
    case todayMovie = "오늘의 영화"
}

final class MainViewController: CustomBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let profileBannerView: ProfileBannerView = ProfileBannerView()
    
    private let mainCollectionView: MainCollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let cv: MainCollectionView = MainCollectionView(layout: layout)
        return cv
    }()
    
    private var trendingDataList: [TrendingResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.requestTMDB(type: TMDBAPI.trending(params: TrendingRequest())) { (response: TrendingResponse) in
            self.trendingDataList = response.results
            self.mainCollectionView.reloadSections([1])
        }
        self.configureNavigationItem()
        self.profileBannerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.profileBannerTapped)))
        self.configureConnectionCollectionView()
        
        self.view.addSubview(profileBannerView)
        self.view.addSubview(mainCollectionView)
        
        self.profileBannerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(150)
        }
        self.mainCollectionView.snp.makeConstraints { make in
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
extension MainViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MainCollectionCellType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainCollectionReusableHeaderView.id, for: indexPath) as? MainCollectionReusableHeaderView {
            if indexPath.section == 0 {
                header.headerType = .recentSearchTerm
                header.allDeleteButtonClosure = {
                    UserDataManager.resetSearchTermList()
                    self.mainCollectionView.reloadSections(IndexSet(integer: 0))
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
        return CGSize(width: collectionView.frame.width, height: MainCollectionReusableHeaderView.height)
    }
}

// CollectionView Cell
extension MainViewController {
    
    private func configureConnectionCollectionView() {
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as? MainCollectionViewCell {
            
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
            size.height = MainCollectionViewCell.recentSearchTermCellHeight
        } else {
            size.height = collectionView.frame.height - MainCollectionViewCell.recentSearchTermCellHeight - (MainCollectionReusableHeaderView.height * CGFloat(MainCollectionCellType.allCases.count))
        }
        return size
    }
}
