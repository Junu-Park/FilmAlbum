//
//  TodayMovieResponse.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/30/25.
//

import Foundation

struct TrendingResponse: Decodable {
    let page: Int
    let results: [TrendingResult]
    let total_pages: Int
    let total_results: Int
}

struct TrendingResult: Decodable {
    let id: Int
    let backdrop_path: String
    let title: String
    let overview: String
    let poster_path: String
    let genre_ids: [Int]
    let release_date: String
    let vote_average: Double
}
