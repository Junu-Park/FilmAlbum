//
//  ImageResponse.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import Foundation

struct ImageResponse: Decodable {
    let id: Int
    let backdrops: [Backdrop]
    let posters: [Poster]
}

struct Backdrop: Decodable {
    let file_path: String
}

struct Poster: Decodable {
    let file_path: String
}
