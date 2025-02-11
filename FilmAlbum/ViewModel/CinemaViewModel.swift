//
//  CinemaViewModel.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/11/25.
//

import Foundation

final class CinemaViewModel: ViewModelProtocol {
    struct Input {
        let viewInit: Observer<()> = Observer(value: ())
        let searchTermAllDelete: Observer<()> = Observer(value: ())
        let searchTermDelete: Observer<Int> = Observer(value: 0)
    }
    struct Output {
        let trendData: Observer<Array<TrendingResult>> = Observer(value: [])
        let reloadSection: Observer<Int> = Observer(value: 0)
    }
    
    var input: Input = Input()
    var output: Output = Output()
    
    init() {
        self.transform()
    }
    
    func transform() {
        self.input.viewInit.bindWithExecute { [weak self] _, nV in
            NetworkManager.requestTMDB(type: .trending(params: TrendingRequest())) {  (response: TrendingResponse) in
                self?.output.trendData.value = response.results
                self?.output.reloadSection.value = 1
            }
        }
        self.input.searchTermAllDelete.bind { [weak self] _, _ in
            UserDataManager.resetSearchTermList()
            NotificationCenter.default.post(name: NSNotification.Name("deleteButtonTapped"), object: nil)
            self?.output.reloadSection.value = 0
        }
        self.input.searchTermDelete.bind { [weak self] _, nV in
            var list = UserDataManager.getSetSearchTermList()
            list.remove(at: nV)
            UserDataManager.getSetSearchTermList(newSearchTermList: list)
            NotificationCenter.default.post(name: NSNotification.Name("deleteButtonTapped"), object: nil)
            self?.output.reloadSection.value = 0
        }
    }
}
