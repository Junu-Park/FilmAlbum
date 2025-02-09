//
//  Observer.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/7/25.
//

import Foundation

final class Observer<T> {
    var value: T {
        didSet(oldVal) {
            self.closure?(oldVal, self.value)
        }
    }
    
    var closure: ((T, T) -> ())?
    
    init(value: T) {
        self.value = value
    }
}
