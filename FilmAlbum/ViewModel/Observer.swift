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
    
    private var closure: ((T, T) -> ())?
    
    init(value: T) {
        self.value = value
    }
    
    func bindWithInit(_ closure: @escaping (T, T) -> ()) {
        closure(self.value, self.value)
        self.closure = closure
    }
    
    func bind(_ closure: @escaping (T, T) -> ()) {
        self.closure = closure
    }
}
