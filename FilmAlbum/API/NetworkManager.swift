//
//  NetworkManager.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/30/25.
//

import UIKit

import Alamofire

enum TMDBAPI {
    static let base: String = "https://api.themoviedb.org/3"
    
    static let imageBase: String = "https://image.tmdb.org/t/p/w400"
    
    static let headers: HTTPHeaders = ["Authorization": APIKey.tmdbAccessToken]
    
    case trending(params: TrendingRequest)
    case search(params: SearchRequest)
    case image(movieID: String)
    case credit(movieID: String, params: CreditRequest)
    
    var path: String {
        switch self {
        case .trending:
            return "/trending/movie/day"
        case .search:
            return "/search/movie"
        case .image(let movieID):
            return "/movie/\(movieID)/images"
        case .credit(let movieID, _):
            return "/movie/\(movieID)/credits"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .trending, .search, .image, .credit:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .trending(let params):
            return params.convertToDictionary
        case .search(let params):
            return params.convertToDictionary
        case .image:
            return nil
        case .credit(_, let params):
            return params.convertToDictionary
        }
    }
}

class NetworkManager {

    private init() {}
    
    static func requestTMDB<T: Decodable>(type: TMDBAPI, successHandler: @escaping (T) -> ()) {
        AF.request(TMDBAPI.base + type.path, method: type.method, parameters: type.parameters, encoding: URLEncoding(destination: .queryString),headers: TMDBAPI.headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                successHandler(value)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
