//
//  UserDataManager.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/28/25.
//

import Foundation

enum UserDefaultsKey: String, CaseIterable {
    case onBoardingComplete = "OnBoardingComplete"
    case nickname = "Nickname"
    case profileImage = "ProfileImage"
    case createdDate = "CreatedDate"
    case likeMovieIDList = "likeMovieIDList"
}

class UserDataManager {
    
    private init() {}
    
    @discardableResult static func getSetOnboardingComplete(newOnboardingComplete: Bool? = nil) -> Bool {
        if let newOnboardingComplete {
            UserDefaults.standard.set(newOnboardingComplete, forKey: UserDefaultsKey.onBoardingComplete.rawValue)
            return newOnboardingComplete
        } else {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.onBoardingComplete.rawValue)
        }
    }
    
    @discardableResult static func getSetNickname(newNickname nickname: String? = nil) -> String {
        if let nickname {
            UserDefaults.standard.set(nickname, forKey: UserDefaultsKey.nickname.rawValue)
            return nickname
        } else {
            return UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) ?? ""
        }
    }
    
    @discardableResult static func getSetProfileImage(newProfileImageType profileImageType: ProfileImage? = nil) -> ProfileImage {
        if let profileImageType {
            UserDefaults.standard.set(profileImageType.rawValue, forKey: UserDefaultsKey.profileImage.rawValue)
            return profileImageType
        } else {
            return ProfileImage(rawValue: UserDefaults.standard.integer(forKey: UserDefaultsKey.profileImage.rawValue)) ?? ProfileImage.randomCase
        }
    }
    
    @discardableResult static func getSetCreatedDateString(newCreatedDate createdDate: Date? = nil) -> String {
        if let createdDate {
            UserDefaults.standard.set(createdDate.convertToCreatedDateString(), forKey: UserDefaultsKey.createdDate.rawValue)
            return createdDate.convertToCreatedDateString()
        } else {
            return UserDefaults.standard.string(forKey: UserDefaultsKey.createdDate.rawValue) ?? Date().convertToCreatedDateString()
        }
    }
    
    @discardableResult static func getSetLikeMovieList(newLikeMovieID: Int? = nil) -> [Int] {
        if let newLikeMovieID {
            var list: [Int] = UserDefaults.standard.array(forKey: UserDefaultsKey.likeMovieIDList.rawValue) as? [Int] ?? []
            list.append(newLikeMovieID)
            UserDefaults.standard.set(list, forKey: UserDefaultsKey.likeMovieIDList.rawValue)
            return list
        } else {
            return UserDefaults.standard.array(forKey: UserDefaultsKey.likeMovieIDList.rawValue) as? [Int] ?? []
        }
    }
    
    static func resetUserData() {
        UserDefaultsKey.allCases.forEach { key in
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
}
