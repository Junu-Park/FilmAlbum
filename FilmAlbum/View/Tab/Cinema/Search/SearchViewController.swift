//
//  SearchViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

import Kingfisher
import SnapKit

enum Genre: Int {
    case action = 28
    case animation = 16
    case crime = 80
    case drama = 18
    case fantasy = 14
    case horror = 27
    case mystery = 9648
    case sf = 878
    case thriller = 53
    case western = 37
    case adventure = 12
    case comedy = 35
    case documentary = 99
    case family = 10751
    case history = 36
    case music = 10402
    case romance = 10749
    case tvMovie = 10770
    case war = 10752
    
    var title: String {
        switch self {
        case .action: 
            return "액션"
        case .animation: 
            return "애니메이션"
        case .crime: 
            return "범죄"
        case .drama: 
            return "드라마"
        case .fantasy: 
            return "판타지"
        case .horror: 
            return "공포"
        case .mystery: 
            return "미스터리"
        case .sf: 
            return "SF"
        case .thriller: 
            return "스릴러"
        case .western: 
            return "서부"
        case .adventure: 
            return "모험"
        case .comedy: 
            return "코미디"
        case .documentary: 
            return "다큐멘터리"
        case .family: 
            return "가족"
        case .history: 
            return "역사"
        case .music: 
            return "음악"
        case .romance: 
            return "로맨스"
        case .tvMovie: 
            return "TV 영화"
        case .war: 
            return "전쟁"
        }
    }
}


final class SearchViewController: CustomBaseViewController {

    private let searchCollectionView: SearchCollectionView = SearchCollectionView(layout: UICollectionViewFlowLayout())
    
    private var searchRequest: SearchRequest = SearchRequest(query: "")
    
    private var searchResponse: SearchResponse = SearchResponse(page: 0, results: [], total_pages: 0, total_results: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationItemSearchBar()
        self.configureConnectionSearchBar()
        self.configureConnectionCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedLikeButtonTappedNotification), name: NSNotification.Name("LikeButtonTapped"), object: nil)
        
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
    
    @objc private func receivedLikeButtonTappedNotification(value: NSNotification) {
        if let info = value.userInfo?["isSearchDetail"] as? Bool, info {
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
        NotificationCenter.default.post(name: NSNotification.Name("LikeButtonTapped"), object: nil, userInfo: ["isSearch": true])
        UIView.performWithoutAnimation {
            self.searchCollectionView.reloadItems(at: [IndexPath(item: sender.tag, section: 0)])
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
            
            if UserDataManager.getSetLikeMovieList().contains(self.searchResponse.results[indexPath.item].id) {
                cell.likeButton.setImage(UIImage.faHeartFill, for: .normal)
            } else {
                cell.likeButton.setImage(UIImage.faHeart, for: .normal)
            }
            cell.tag = indexPath.item
            cell.titleLabel.text = self.searchResponse.results[indexPath.item].title
            cell.dateLabel.text = self.searchResponse.results[indexPath.item].release_date.replaceLineWithPoint()
            cell.posterImageView.kf.setImage(with: URL(string: TMDBAPI.image200Base + (self.searchResponse.results[indexPath.item].poster_path ?? "")))
            
            if let genre1 = self.searchResponse.results[indexPath.item].genre_ids.first {
                cell.genre1Label.text = Genre.init(rawValue: genre1)?.title
            }
            if self.searchResponse.results[indexPath.item].genre_ids.count > 1 {
                cell.genre2Label.text =
                Genre.init(rawValue: self.searchResponse.results[indexPath.item].genre_ids[1])?.title
            }
            
            cell.likeButton.addTarget(self, action: #selector(self.likeButtonTapped), for: .touchUpInside)
            cell.likeButton.tag = indexPath.item
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: collectionView.frame.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc: SearchDetailViewController = SearchDetailViewController(movieData: self.searchResponse.results[indexPath.item], viewType: .searchDetail(movieTitle: self.searchResponse.results[indexPath.item].title))
        self.navigationController?.pushViewController(vc, animated: true)
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
