//
//  TrendingRequest.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/30/25.
//

import Foundation

struct TrendingRequest: Encodable {
    var language: String = "ko-KR"
    var page: Int = 1
}
