//
//  ProfileImageType.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import Foundation

enum ProfileImageType: Int, CaseIterable {
    case profile0 = 0
    case profile1
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
    
    var imageName: String {
        return "profile_\(self.rawValue)"
    }
    
    static func getRandomCase() -> ProfileImageType {
        print(#function)
        return ProfileImageType.allCases.randomElement() ?? ProfileImageType.profile0
    }
}
