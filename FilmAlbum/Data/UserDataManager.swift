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
    case likeMovieIDList = "LikeMovieIDList"
    case searchTermList = "SearchTermList"
    case mbti = "MBTI"
}

final class UserDataManager {
    
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
    
    @discardableResult static func getSetProfileImage(newProfileImageType profileImageType: ProfileImageType? = nil) -> ProfileImageType {
        if let profileImageType {
            UserDefaults.standard.set(profileImageType.rawValue, forKey: UserDefaultsKey.profileImage.rawValue)
            return profileImageType
        } else {
            if UserDefaults.standard.bool(forKey: UserDefaultsKey.onBoardingComplete.rawValue) {
                return ProfileImageType(rawValue: UserDefaults.standard.integer(forKey: UserDefaultsKey.profileImage.rawValue)) ?? ProfileImageType.getRandomCase()
            } else {
                return ProfileImageType.getRandomCase()
            }
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
    
    @discardableResult static func getSetLikeMovieList(newLikeMovieIDList: [Int]? = nil) -> [Int] {
        if let newLikeMovieIDList {
            UserDefaults.standard.set(newLikeMovieIDList, forKey: UserDefaultsKey.likeMovieIDList.rawValue)
            return newLikeMovieIDList
        } else {
            return UserDefaults.standard.array(forKey: UserDefaultsKey.likeMovieIDList.rawValue) as? [Int] ?? []
        }
    }
    
    @discardableResult static func getSetSearchTermList(newSearchTermList: [String]? = nil) -> [String] {
        if let newSearchTermList {
            UserDefaults.standard.set(newSearchTermList, forKey: UserDefaultsKey.searchTermList.rawValue)
            return newSearchTermList
        } else {
            return UserDefaults.standard.array(forKey: UserDefaultsKey.searchTermList.rawValue) as? [String] ?? []
        }
    }
    
    @discardableResult static func getSetMBTI(newMBTI: Array<String?> = []) -> Array<String?> {
        if !newMBTI.isEmpty {
            if let mbit = newMBTI as? Array<String> {
                UserDefaults.standard.set(mbit, forKey: UserDefaultsKey.mbti.rawValue)
            }
            return Array(repeating: nil, count: 4)
        } else {
            return UserDefaults.standard.array(forKey: UserDefaultsKey.mbti.rawValue) as? [String] ?? Array(repeating: nil, count: 4)
        }
    }
    
    static func resetUserData() {
        UserDefaultsKey.allCases.forEach { key in
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
    
    static func resetSearchTermList() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.searchTermList.rawValue)
    }
}
