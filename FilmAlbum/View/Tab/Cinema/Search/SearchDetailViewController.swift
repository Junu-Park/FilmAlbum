//
//  SearchDetailViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/1/25.
//

import UIKit

import SnapKit

final class SearchDetailViewController: CustomBaseViewController {

    private let mainScrollView: UIScrollView = UIScrollView()
    private let backdropScrollView: UIScrollView = {
        let sv: UIScrollView = UIScrollView()
        sv.isPagingEnabled = true
        return sv
    }()
    private lazy var detailDataView: SearchDetailDataView = SearchDetailDataView(data: self.movieData)
    
    var movieData: SearchResult = SearchResult(id: 0, backdrop_path: "", title: "", overview: "", poster_path: "", genre_ids: [], release_date: "", vote_average: 0)
    var movieImage: ImageResponse = ImageResponse(id: 0, backdrops: [], posters: [])
    var movieCredit: CreditResponse = CreditResponse(id: 0, casts: [])
    
    init(movieData: SearchResult, viewType: ViewType) {
        super.init(viewType: viewType)
        self.movieData = movieData
        self.detailDataView.data = self.movieData
        self.configureNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.mainScrollView)
        self.mainScrollView.addSubview(self.backdropScrollView)
        self.mainScrollView.addSubview(self.detailDataView)
        
        self.mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.backdropScrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        self.detailDataView.snp.makeConstraints { make in
            make.top.equalTo(self.backdropScrollView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureNavigationItem() {
        let image: UIImage = UserDataManager.getSetLikeMovieList().contains(self.movieData.id) ? UIImage.faHeartFill : UIImage.faHeart
        let rightItem: UIBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.likeButtonTapped))
        self.navigationItem.setRightBarButton(rightItem, animated: true)
    }
    
    @objc private func likeButtonTapped() {
        
        var list: [Int] = UserDataManager.getSetLikeMovieList()
        if let index = list.firstIndex(of: self.movieData.id) {
            list.remove(at: index)
        } else {
            list.append(self.movieData.id)
        }
        UserDataManager.getSetLikeMovieList(newLikeMovieIDList: list)
        
        let image: UIImage = UserDataManager.getSetLikeMovieList().contains(self.movieData.id) ? UIImage.faHeartFill : UIImage.faHeart
        self.navigationItem.rightBarButtonItem?.image = image
        
        NotificationCenter.default.post(name: NSNotification.Name("LikeButtonTapped"), object: nil, userInfo: ["isSearchDetail": true])
    }
}
