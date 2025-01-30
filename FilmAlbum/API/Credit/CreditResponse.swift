//
//  CreditResponse.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import Foundation

struct CreditResponse: Decodable {
    var id: Int
    var casts: [Cast]
    
    enum CodingKeys: String, CodingKey {
        case id
        case casts = "cast"
    }
}
struct Cast: Decodable {
    var name: String
    var character: String
    var profile_path: String
}
