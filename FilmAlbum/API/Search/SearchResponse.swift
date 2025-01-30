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
    let backdrop_path: String
    let title: String
    let overview: String
    let poster_path: String
    let genre_ids: [Int]
    let release_date: String
    let vote_average: Double
}
