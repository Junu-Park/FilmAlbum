//
//  SearchDetailViewModel.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/12/25.
//

import Foundation

final class SearchDetailViewModel: ViewModelProtocol {
    struct Input {
        let movieData: Observer<SearchResult?> = Observer(value: nil)
        let initWithMovieID: Observer<Int> = Observer(value: 0)
        let movieLike: Observer<()> = Observer(value: ())
        let movieLikeTapped: Observer<()> = Observer(value: ())
    }
    
    struct Output {
        let movieData: Observer<SearchResult> = Observer(value: SearchResult(id: 0, backdrop_path: nil, title: "", overview: "", poster_path: nil, genre_ids: [], release_date: "", vote_average: 0))
        let movieBackdrops: Observer<[Backdrop]> = Observer(value: [])
        let movieCredit: Observer<[Cast]> = Observer(value: [])
        let moviePosters: Observer<[Poster]> = Observer(value: [])
        let movieLike: Observer<Bool> = Observer(value: false)
        let reload: Observer<()> = Observer(value: ())
    }
    
    var input = Input()
    var output = Output()
    
    init() {
        self.transform()
    }
    
    func transform() {
        self.input.movieData.bind { _, nV in
            if let nV {
                self.output.movieData.value = nV
            } else {
                return
            }
        }
        self.input.initWithMovieID.bind { _, nV in
            
            let group = DispatchGroup()
            
            group.enter()
            NetworkManager.requestTMDB(type: .image(movieID: nV)) { (response: ImageResponse) in
                self.output.movieBackdrops.value = response.backdrops
                self.output.moviePosters.value = response.posters
                group.leave()
            }
            
            group.enter()
            NetworkManager.requestTMDB(type: .credit(movieID: nV, params: CreditRequest())) { (response: CreditResponse) in
                self.output.movieCredit.value = response.casts
                group.leave()
            }
            
            group.notify(queue: .main) {
                self.output.reload.value = ()
            }
        }
        self.input.movieLike.bind { _, _ in
            if let id = self.input.movieData.value?.id {
                if UserDataManager.likeMovieList.firstIndex(of: id) != nil {
                    self.output.movieLike.value = true
                } else {
                    self.output.movieLike.value = false
                }
            }
        }
        self.input.movieLikeTapped.bind { _, _ in
            if let id = self.input.movieData.value?.id {
                var list: [Int] = UserDataManager.likeMovieList
                if let index = list.firstIndex(of: id) {
                    list.remove(at: index)
                    self.output.movieLike.value = false
                } else {
                    list.append(id)
                    self.output.movieLike.value = true
                }
                UserDataManager.likeMovieList = list
                
                NotificationCenter.default.post(name: NSNotification.Name("LikeButtonTapped"), object: nil, userInfo: ["isSearchDetail": true])
            }
        }
    }
}
