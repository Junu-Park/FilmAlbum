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
    private let synopsisTitle: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa14BoldFont
        lb.text = "Synopsis"
        return lb
    }()
    private lazy var synopsisButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setAttributedTitle(NSAttributedString(string: "More", attributes: [.foregroundColor: UIColor.faAccent, .font: UIFont.fa14BoldFont]), for: .normal)
        btn.setAttributedTitle(NSAttributedString(string: "More", attributes: [.foregroundColor: UIColor.faLightGray, .font: UIFont.fa14BoldFont]), for: .highlighted)
        btn.addTarget(self, action: #selector(self.synopsisButtonTapped), for: .touchUpInside)
        return btn
    }()
    private let synopsisLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa14Font
        lb.numberOfLines = 3
        return lb
    }()
    private let castLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa14BoldFont
        lb.text = "Cast"
        return lb
    }()
    private let posterLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa14BoldFont
        lb.text = "Poster"
        return lb
    }()
    
    var movieData: SearchResult = SearchResult(id: 0, backdrop_path: "", title: "", overview: "", poster_path: "", genre_ids: [], release_date: "", vote_average: 0)
    var movieImage: ImageResponse = ImageResponse(id: 0, backdrops: [], posters: [])
    var movieCredit: CreditResponse = CreditResponse(id: 0, casts: [])
    
    init(movieData: SearchResult, viewType: ViewType) {
        super.init(viewType: viewType)
        self.movieData = movieData
        self.detailDataView.data = self.movieData
        self.configureNavigationItem()
        NetworkManager.requestTMDB(type: .image(movieID: self.movieData.id)) { (response: ImageResponse) in
            self.movieImage = response
        }
        NetworkManager.requestTMDB(type: .credit(movieID: self.movieData.id, params: CreditRequest())) { (response: CreditResponse) in
            self.movieCredit = response
        }
        self.synopsisLabel.text = self.movieData.overview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.mainScrollView)
        self.mainScrollView.addSubview(self.backdropScrollView)
        self.mainScrollView.addSubview(self.detailDataView)
        self.mainScrollView.addSubview(self.synopsisTitle)
        self.mainScrollView.addSubview(self.synopsisButton)
        self.mainScrollView.addSubview(self.synopsisLabel)
        
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
        self.synopsisTitle.snp.makeConstraints { make in
            make.top.equalTo(self.detailDataView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        self.synopsisButton.snp.makeConstraints { make in
            make.top.equalTo(self.detailDataView.snp.bottom).offset(32)
            make.trailing.equalToSuperview().inset(16)
        }
        self.synopsisLabel.snp.makeConstraints { make in
            make.top.equalTo(self.synopsisTitle.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
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
    
    @objc private func synopsisButtonTapped() {
        if self.synopsisLabel.numberOfLines == 3 {
            self.synopsisLabel.numberOfLines = 0
            self.synopsisButton.setAttributedTitle(NSAttributedString(string: "Hide", attributes: [.foregroundColor: UIColor.faAccent, .font: UIFont.fa14BoldFont]), for: .normal)
            self.synopsisButton.setAttributedTitle(NSAttributedString(string: "Hide", attributes: [.foregroundColor: UIColor.faLightGray, .font: UIFont.fa14BoldFont]), for: .highlighted)
        } else {
            self.synopsisLabel.numberOfLines = 3
            self.synopsisButton.setAttributedTitle(NSAttributedString(string: "More", attributes: [.foregroundColor: UIColor.faAccent, .font: UIFont.fa14BoldFont]), for: .normal)
            self.synopsisButton.setAttributedTitle(NSAttributedString(string: "More", attributes: [.foregroundColor: UIColor.faLightGray, .font: UIFont.fa14BoldFont]), for: .highlighted)
        }
    }
}
