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
    let backdropPath: String
    let title: String
    let overview: String
    let posterPath: String
    let genreIDs: [Int]
    let releaseDate: String
    let voteAverage: Double
}
