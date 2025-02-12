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
    
    let viewModel: SearchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationItemSearchBar()
        self.configureConnectionSearchBar()
        self.configureConnectionCollectionView()
    }
    
    override func configureHierarchy() {
        self.view.addSubview(self.searchCollectionView)
    }
    
    override func configureLayout() {
        self.searchCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func binding() {
        self.viewModel.output.searchResult.bind { [weak self] oV, nV in
            self?.searchCollectionView.checkNoSearchData(count: nV.count)
        }
        self.viewModel.output.scrollToTop.bind { [weak self] _, _ in
            self?.searchCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
        self.viewModel.output.reload.bind { [weak self] _, nV in
            if let nV {
                UIView.performWithoutAnimation {
                    self?.searchCollectionView.reloadItems(at: [IndexPath(row: nV, section: 0)])
                }
            } else {
                self?.searchCollectionView.reloadData()
            }
        }
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        self.viewModel.input.likeButtonTapped.value = sender.tag
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func configureConnectionSearchBar() {
        self.navigationItem.searchController?.searchBar.delegate = self
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if !(searchBar.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.viewModel.input.searchQuery.value = searchBar.text
            return true
        }
        return false
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func configureConnectionCollectionView() {
        self.searchCollectionView.delegate = self
        self.searchCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.output.searchResult.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as? SearchCollectionViewCell {
            
            if UserDataManager.getSetLikeMovieList().contains(self.viewModel.output.searchResult.value[indexPath.item].id) {
                cell.likeButton.setImage(UIImage.faHeartFill, for: .normal)
            } else {
                cell.likeButton.setImage(UIImage.faHeart, for: .normal)
            }
            cell.tag = indexPath.item
            cell.titleLabel.text = self.viewModel.output.searchResult.value[indexPath.item].title
            cell.dateLabel.text = self.viewModel.output.searchResult.value[indexPath.item].release_date.replaceLineWithPoint()
            cell.posterImageView.kf.setImage(with: URL(string: TMDBAPI.image200Base + (self.viewModel.output.searchResult.value[indexPath.item].poster_path ?? "")))
            
            if let genre1 = self.viewModel.output.searchResult.value[indexPath.item].genre_ids.first {
                cell.genre1Label.isHidden = false
                cell.genre1Label.text = Genre.init(rawValue: genre1)?.title
            } else {
                cell.genre1Label.isHidden = true
            }
            if self.viewModel.output.searchResult.value[indexPath.item].genre_ids.count > 1 {
                cell.genre2Label.isHidden = false
                cell.genre2Label.text = Genre.init(rawValue: self.viewModel.output.searchResult.value[indexPath.item].genre_ids[1])?.title
            } else {
                cell.genre2Label.isHidden = true
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
        let vc: SearchDetailViewController = SearchDetailViewController(viewType: .searchDetail(movieTitle: self.viewModel.output.searchResult.value[indexPath.item].title))
        vc.viewModel.input.movieData.value = self.viewModel.output.searchResult.value[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.viewModel.input.searchQueryPagination.value = indexPath.item
    }
}
