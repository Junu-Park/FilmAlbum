//
//  SearchViewModel.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/11/25.
//

import Foundation

final class SearchViewModel: ViewModelProtocol {
    struct Input {
        let searchQuery: Observer<String?> = Observer(value: nil)
        let searchQueryPagination: Observer<Int> = Observer(value: 0)
        let likeButtonTapped: Observer<Int> = Observer(value: 0)
    }
    struct Output {
        let searchResult: Observer<[SearchResult]> = Observer(value: [])
        let scrollToTop: Observer<()> = Observer(value: ())
        let reload: Observer<Int?> = Observer(value: nil)
    }

    private(set) var input: Input = Input()
    private(set) var output: Output = Output()
    
    private var searchRequest: SearchRequest = SearchRequest(query: "")
    private var searchResponse: SearchResponse = SearchResponse(page: 0, results: [], total_pages: 0, total_results: 0)
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedLikeButtonTappedNotification), name: NSNotification.Name("LikeButtonTapped"), object: nil)
        self.transform()
    }
    
    func transform() {
        self.input.searchQuery.bind { [weak self] oV, nV in
            if let self, let nV, nV != oV ?? "" {
                self.saveSearchTerm(term: nV)
                self.searchRequest = SearchRequest(query: nV)
                NetworkManager.requestTMDB(type: .search(params: self.searchRequest)) { (response: SearchResponse) in
                    self.searchResponse = response
                    self.output.searchResult.value = response.results
                    self.output.reload.value = nil
                    if !response.results.isEmpty {
                        self.output.scrollToTop.value = ()
                    }
                }
            } else {
               return
            }
        }
        self.input.searchQueryPagination.bind { [weak self] _, nV in
            if let self, self.checkPagination(index: nV) {
                self.searchRequest.page += 1
                NetworkManager.requestTMDB(type: .search(params: self.searchRequest)) { (response: SearchResponse) in
                    self.searchResponse.results += response.results
                    self.output.searchResult.value = self.searchResponse.results
                    self.output.reload.value = nil
                }
            } else {
                return
            }
        }
        self.input.likeButtonTapped.bind { [weak self] _, nV in
            if let self {
                var list: [Int] = UserDataManager.likeMovieList
                if let order = list.firstIndex(of: self.searchResponse.results[nV].id) {
                    list.remove(at: order)
                } else {
                    list.append(self.searchResponse.results[nV].id)
                }
                UserDataManager.likeMovieList = list
                NotificationCenter.default.post(name: NSNotification.Name("LikeButtonTapped"), object: nil, userInfo: ["isSearch": true])
                self.output.reload.value = nV
            } else {
                return
            }
        }
    }
    
    private func saveSearchTerm(term: String) {
        if !UserDataManager.getSetSearchTermList().contains(term) {
            var list: [String] = UserDataManager.getSetSearchTermList()
            list.insert(term, at: 0)
            UserDataManager.getSetSearchTermList(newSearchTermList: list)
            NotificationCenter.default.post(name: NSNotification.Name("searchBarEnterTapped"), object: nil)
        }
    }
    
    private func checkPagination(index: Int) -> Bool {
        let currentCount = self.searchResponse.results.count
        return (index + 2 == currentCount) && (currentCount < self.searchResponse.total_results)
    }
    
    @objc private func receivedLikeButtonTappedNotification(value: NSNotification) {
        if let info = value.userInfo?["isSearchDetail"] as? Bool, info {
            self.output.reload.value = nil
        }
    }
}
