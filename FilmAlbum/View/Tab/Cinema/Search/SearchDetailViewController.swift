//
//  SearchDetailViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/1/25.
//

import UIKit

final class SearchDetailViewController: CustomBaseViewController {

    private let scrollView: UIScrollView = UIScrollView()
    
    var movieData: SearchResult = SearchResult(id: 0, backdrop_path: "", title: "", overview: "", poster_path: "", genre_ids: [], release_date: "", vote_average: 0)
    var movieImage: ImageResponse = ImageResponse(id: 0, backdrops: [], posters: [])
    var movieCredit: CreditResponse = CreditResponse(id: 0, casts: [])
    
    init(movieData: SearchResult, viewType: ViewType) {
        super.init(viewType: viewType)
        self.movieData = movieData
        self.configureNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
