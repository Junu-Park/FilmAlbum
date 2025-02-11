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

protocol SearchCollectionViewButtonDelegate: AnyObject {
    func searchTermTapped(searchTerm: String)
    func searchTermDeleteTapped(index: Int)
}

protocol TodayMovieCollectionViewDelegate: AnyObject {
    func todayMovieTapped(data: SearchResult)
}

final class CinemaViewController: CustomBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let profileBannerView: ProfileBannerView = ProfileBannerView()
    
    private let cinemaCollectionView: CinemaCollectionView = CinemaCollectionView(layout: UICollectionViewFlowLayout())
    
    private let viewModel: CinemaViewModel = CinemaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigationItem()
        self.configureConnectionCollectionView()
        self.profileBannerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.profileBannerTapped)))
        
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
    
    override func binding() {
        self.viewModel.output.trendData.bind { [weak self] _, nV in
            self?.cinemaCollectionView.reloadSections(IndexSet(integer: 1))
        }
    }
    
    @objc private func searchButtonTapped() {
        self.navigationController?.pushViewController(SearchViewController(viewType: .search), animated: true)
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
                    NotificationCenter.default.post(name: NSNotification.Name("deleteButtonTapped"), object: nil)
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
                cell.searchDelegate = self
            } else {
                cell.collectionCellType = .todayMovie
                cell.trendingDataList = self.viewModel.output.trendData.value
                cell.todayMovieDelegate = self
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

extension CinemaViewController: SearchCollectionViewButtonDelegate {
    func searchTermTapped(searchTerm: String) {
        let vc: SearchViewController = SearchViewController(viewType: .search)
        vc.searchingWithSearchTerm(searchTerm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchTermDeleteTapped(index: Int) {
        var list = UserDataManager.getSetSearchTermList()
        list.remove(at: index)
        UserDataManager.getSetSearchTermList(newSearchTermList: list)
        NotificationCenter.default.post(name: NSNotification.Name("deleteButtonTapped"), object: nil)
        self.cinemaCollectionView.reloadSections(IndexSet(integer: 0))
    }
}

extension CinemaViewController: TodayMovieCollectionViewDelegate {
    func todayMovieTapped(data: SearchResult) {
        self.navigationController?.pushViewController(SearchDetailViewController(movieData: data, viewType: .searchDetail(movieTitle: data.title)), animated: true)
    }
}
