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
    }
    struct Output {
        let trendData: Observer<Array<TrendingResult>> = Observer(value: [])
    }
    
    var input: Input = Input()
    var output: Output = Output()
    
    init() {
        self.transform()
    }
    
    func transform() {
        self.input.viewInit.bindWithExecute { _, nV in
            NetworkManager.requestTMDB(type: .trending(params: TrendingRequest())) { [weak self] (response: TrendingResponse) in
                self?.output.trendData.value = response.results
            }
        }
    }
}
