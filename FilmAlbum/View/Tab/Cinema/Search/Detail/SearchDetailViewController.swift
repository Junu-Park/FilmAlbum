//
//  SearchDetailViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/1/25.
//

import UIKit

import Kingfisher
import SnapKit

final class SearchDetailViewController: CustomBaseViewController {

    private let mainScrollView: UIScrollView = UIScrollView()
    private let backdropPageControl: UIPageControl = {
        let pc: UIPageControl = UIPageControl()
        pc.layer.cornerRadius = 15
        pc.clipsToBounds = true
        pc.backgroundColor = UIColor.faDarkGray.withAlphaComponent(0.5)
        pc.currentPage = 0
        pc.isUserInteractionEnabled = false
        return pc
    }()
    private let backdropCollectionView: BackdropCollectionView = BackdropCollectionView(layout: UICollectionViewFlowLayout())
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
    private let castTitle: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa14BoldFont
        lb.text = "Cast"
        return lb
    }()
    private let castCollectionView: CastCollectionView = CastCollectionView(layout: UICollectionViewFlowLayout())
    private let posterTitle: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa14BoldFont
        lb.text = "Poster"
        return lb
    }()
    private let posterCollectionView: PosterCollectionView = PosterCollectionView(layout: UICollectionViewFlowLayout())
    
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
            self.posterCollectionView.reloadData()
            self.backdropCollectionView.reloadData()
        }
        NetworkManager.requestTMDB(type: .credit(movieID: self.movieData.id, params: CreditRequest())) { (response: CreditResponse) in
            self.movieCredit = response
            self.castCollectionView.reloadData()
        }
        self.synopsisLabel.text = self.movieData.overview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureConnectionCollectionView()
        
        self.view.addSubview(self.mainScrollView)
        self.mainScrollView.addSubview(self.backdropCollectionView)
        self.mainScrollView.addSubview(self.backdropPageControl)
        self.mainScrollView.addSubview(self.detailDataView)
        self.mainScrollView.addSubview(self.synopsisTitle)
        self.mainScrollView.addSubview(self.synopsisButton)
        self.mainScrollView.addSubview(self.synopsisLabel)
        self.mainScrollView.addSubview(self.castTitle)
        self.mainScrollView.addSubview(self.castCollectionView)
        self.mainScrollView.addSubview(self.posterTitle)
        self.mainScrollView.addSubview(self.posterCollectionView)
        
        self.mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.backdropCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        self.backdropPageControl.snp.makeConstraints { make in
            make.centerX.bottom.equalTo(self.backdropCollectionView)
            make.bottom.equalTo(self.backdropCollectionView).offset(-16)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(30)
        }
        self.detailDataView.snp.makeConstraints { make in
            make.top.equalTo(self.backdropCollectionView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        self.synopsisTitle.snp.makeConstraints { make in
            make.top.equalTo(self.detailDataView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        self.synopsisButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.synopsisTitle)
            make.trailing.equalToSuperview().inset(16)
        }
        self.synopsisLabel.snp.makeConstraints { make in
            make.top.equalTo(self.synopsisTitle.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        self.castTitle.snp.makeConstraints { make in
            make.top.equalTo(self.synopsisLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        self.castCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.castTitle.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(132)
        }
        self.posterTitle.snp.makeConstraints { make in
            make.top.equalTo(self.castCollectionView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        self.posterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.posterTitle.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(166)
            make.bottom.equalToSuperview()
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

extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func configureConnectionCollectionView() {
        self.backdropCollectionView.tag = 1
        self.backdropCollectionView.delegate = self
        self.backdropCollectionView.dataSource = self
        self.castCollectionView.tag = 2
        self.castCollectionView.delegate = self
        self.castCollectionView.dataSource = self
        self.posterCollectionView.tag = 3
        self.posterCollectionView.delegate = self
        self.posterCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 1 {
            if self.movieImage.backdrops.count < 5 {
                self.backdropPageControl.numberOfPages = self.movieImage.backdrops.count
                return self.movieImage.backdrops.count
            } else {
                self.backdropPageControl.numberOfPages = 5
                return 5
            }
        } else if collectionView.tag == 2 {
            return self.movieCredit.casts.count
        } else if collectionView.tag == 3 {
            return self.movieImage.posters.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.id, for: indexPath) as? BackdropCollectionViewCell {
                cell.backdropImageView.kf.setImage(with: URL(string: TMDBAPI.image400Base + (self.movieImage.backdrops[indexPath.item].file_path)))
                return cell
            } else {
                return UICollectionViewCell()
            }
        } else if collectionView.tag == 2 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as? CastCollectionViewCell {
                cell.castImage.kf.setImage(with: URL(string: TMDBAPI.image200Base + (self.movieCredit.casts[indexPath.item].profile_path ?? "")))
                cell.castKoName.text = self.movieCredit.casts[indexPath.item].name
                cell.castCharacterName.text = self.movieCredit.casts[indexPath.item].character
                return cell
            } else {
                return UICollectionViewCell()
            }
        } else if collectionView.tag == 3 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCollectionViewCell", for: indexPath) as? PosterCollectionViewCell {
                cell.posterImageView.kf.setImage(with: URL(string: TMDBAPI.image200Base + (self.movieImage.posters[indexPath.item].file_path)))
                return cell
            } else {
                return UICollectionViewCell()
            }
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return collectionView.frame.size
        } else if collectionView.tag == 2 {
            return CGSize(width: 132, height: 50)
        } else if collectionView.tag == 3 {
            return CGSize(width: 100, height: 150)
        } else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            self.backdropPageControl.currentPage = indexPath.item
        }
    }
}
