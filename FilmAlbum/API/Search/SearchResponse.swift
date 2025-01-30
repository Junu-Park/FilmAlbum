//
//  SearchResponse.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import Foundation

struct SearchResponse: Decodable {
    let page: Int
    let results: [SearchResult]
    let total_pages: Int
    let total_results: Int
}

struct SearchResult: Decodable {
    let id: Int
    let backdropPath: String
    let title: String
    let overview: String
    let posterPath: String
    let genreIDs: [Int]
    let releaseDate: String
    let voteAverage: Double
}
