//
//  ProfileImage.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import Foundation

enum ProfileImage: Int {
    case profile1 = 1
    case profile2
    case profile3
    case profile4
    case profile5
    case profile6
    case profile7
    case profile8
    case profile9
    case profile10
    case profile11
    
    func getImageName() -> String {
        return "profile_\(self.rawValue)"
    }
}
