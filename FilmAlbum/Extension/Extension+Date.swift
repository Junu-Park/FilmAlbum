//
//  Extension+Date.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/28/25.
//

import Foundation

extension Date {
    func convertToCreatedDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd 가입"
        return formatter.string(from: self)
    }
}
