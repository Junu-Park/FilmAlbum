//
//  ViewModelProtocol.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/11/25.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform()
}
