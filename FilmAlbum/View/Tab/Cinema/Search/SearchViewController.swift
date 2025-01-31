//
//  SearchViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

import Kingfisher
import SnapKit

final class SearchViewController: CustomBaseViewController {

    private let searchCollectionView: SearchCollectionView = SearchCollectionView(layout: UICollectionViewFlowLayout())
    
    private var searchRequest: SearchRequest = SearchRequest(query: "")
    
    private var searchResponse: SearchResponse = SearchResponse(page: 0, results: [], total_pages: 0, total_results: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationItemSearchBar()
        self.configureConnectionSearchBar()
        self.configureConnectionCollectionView()
        
        self.view.addSubview(self.searchCollectionView)
        
        self.searchCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func searchingWithSearchTerm(_ searchTerm: String) {
        self.navigationItem.searchController?.searchBar.text = searchTerm
        self.searchRequest.query = searchTerm
        NetworkManager.requestTMDB(type: .search(params: self.searchRequest)) { (response: SearchResponse) in
            self.searchResponse = response
            self.searchCollectionView.reloadData()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func configureConnectionSearchBar() {
        self.navigationItem.searchController?.searchBar.delegate = self
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if let searchTerm = searchBar.text, !searchTerm.isEmpty, searchTerm != self.searchRequest.query {
            if !UserDataManager.getSetSearchTermList().contains(searchTerm) {
                var list: [String] = UserDataManager.getSetSearchTermList()
                list.insert(searchTerm, at: 0)
                UserDataManager.getSetSearchTermList(newSearchTermList: list)
                NotificationCenter.default.post(name: NSNotification.Name("searchBarEnterTapped"), object: nil)
            }
            self.searchResponse = SearchResponse(page: 0, results: [], total_pages: 0, total_results: 0)
            self.searchRequest.page = 1
            self.searchRequest.query = searchTerm
            NetworkManager.requestTMDB(type: .search(params: self.searchRequest)) { (response: SearchResponse) in
                self.searchResponse = response
                self.searchCollectionView.reloadData()
            }
            return true
        } else {
            return false
        }
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        var list: [Int] = UserDataManager.getSetLikeMovieList()
        if let order = list.firstIndex(of: self.searchResponse.results[sender.tag].id) {
            list.remove(at: order)
        } else {
            list.append(self.searchResponse.results[sender.tag].id)
        }
        UserDataManager.getSetLikeMovieList(newLikeMovieIDList: list)
        NotificationCenter.default.post(name: NSNotification.Name("LikeButtonTapped"), object: nil, userInfo: ["isCinemaCollectionViewReload": true])
        UIView.performWithoutAnimation {
            self.searchCollectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func configureConnectionCollectionView() {
        self.searchCollectionView.delegate = self
        self.searchCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchResponse.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as? SearchCollectionViewCell {
            
            if UserDataManager.getSetLikeMovieList().contains(self.searchResponse.results[indexPath.row].id) {
                cell.likeButton.setImage(UIImage.faHeartFill, for: .normal)
            } else {
                cell.likeButton.setImage(UIImage.faHeart, for: .normal)
            }
            cell.tag = indexPath.row
            cell.titleLabel.text = self.searchResponse.results[indexPath.row].title
            cell.dateLabel.text = self.searchResponse.results[indexPath.row].release_date.replaceLineWithPoint()
            cell.posterImageView.kf.setImage(with: URL(string: TMDBAPI.image200Base + (self.searchResponse.results[indexPath.row].poster_path ?? "")))
            cell.likeButton.addTarget(self, action: #selector(self.likeButtonTapped), for: .touchUpInside)
            cell.likeButton.tag = indexPath.row
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: collectionView.frame.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return 
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.item + 2 == self.searchResponse.results.count) && self.searchResponse.results.count < self.searchResponse.total_results {
            self.searchRequest.page += 1
            NetworkManager.requestTMDB(type: .search(params: self.searchRequest)) { (response: SearchResponse) in
                self.searchResponse.results += response.results
                self.searchCollectionView.reloadData()
            }
        }
    }
}
