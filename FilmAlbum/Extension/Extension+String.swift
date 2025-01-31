//
//  Extension+String.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import Foundation

extension String {
    func replaceLineWithPoint() -> String {
        return self.replacingOccurrences(of: "-", with: ". ")
    }
}
