//
//  SearchDetailDataView.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/1/25.
//

import UIKit

import SnapKit

final class SearchDetailDataView: UIView {
    
    private lazy var date: UIButton = {
        let btn: UIButton = UIButton()
        btn.isUserInteractionEnabled = false
        btn.setTitleColor(UIColor.faLightGray, for: .normal)
        btn.setImage(UIImage.faCalendar, for: .normal)
        btn.tintColor = UIColor.faLightGray
        return btn
    }()
    
    private lazy var rating: UIButton = {
        let btn: UIButton = UIButton()
        btn.isUserInteractionEnabled = false
        btn.setTitleColor(UIColor.faLightGray, for: .normal)
        btn.setImage(UIImage.faStarFill, for: .normal)
        btn.tintColor = UIColor.faLightGray
        return btn
    }()
    
    private lazy var genre: UIButton = {
        let btn: UIButton = UIButton()
        btn.isUserInteractionEnabled = false
        btn.setTitleColor(UIColor.faLightGray, for: .normal)
        btn.setImage(UIImage.faFilmFill, for: .normal)
        btn.tintColor = UIColor.faLightGray
        return btn
    }()
    
    private let divider1: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.faLightGray
        return view
    }()
    
    private let divider2: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.faLightGray
        return view
    }()
    
    lazy var data: SearchResult = SearchResult(id: 0, backdrop_path: "", title: "", overview: "", poster_path: "", genre_ids: [], release_date: "", vote_average: 0) {
        didSet {
            self.date.setAttributedTitle(NSAttributedString(string: self.data.release_date, attributes: [.font: UIFont.fa12Font]), for: .normal)
            self.rating.setAttributedTitle(NSAttributedString(string: "\(self.data.vote_average)", attributes: [.font: UIFont.fa12Font]), for: .normal)
            let genreString = self.data.genre_ids.map { id in
                Genre.init(rawValue: id)?.title ?? "장르 오류"
            }.prefix(2).joined(separator: ", ")
            self .genre.setAttributedTitle(NSAttributedString(string: genreString, attributes: [.font: UIFont.fa12Font]), for: .normal)
        }
    }
    
    init(data: SearchResult) {
        super.init(frame: .zero)
        
        self.data = data
        self.addSubview(self.date)
        self.addSubview(self.divider1)
        self.addSubview(self.rating)
        self.addSubview(self.divider2)
        self.addSubview(self.genre)
        
        self.date.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        self.divider1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.date.snp.trailing).offset(16)
            make.width.equalTo(1)
            make.height.equalTo(16)
        }
        self.rating.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalTo(self.divider1.snp.trailing).offset(16)
        }
        self.divider2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.rating.snp.trailing).offset(16)
            make.width.equalTo(1)
            make.height.equalTo(16)
        }
        self.genre.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.divider2.snp.trailing).offset(16)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
