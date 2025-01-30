//
//  SearchRequest.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import Foundation

struct SearchRequest {
    var query: String
    var include_adult: Bool = false
    var language: String = "ko-KR"
    var page: Int = 1
}
