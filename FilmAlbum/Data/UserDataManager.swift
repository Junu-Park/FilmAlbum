//
//  UserDataManager.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/28/25.
//

import Foundation

final class UserDataManager {
    
    private enum UserDefaultsKey: String, CaseIterable {
        case onBoardingComplete = "OnBoardingComplete"
        case nickname = "Nickname"
        case profileImage = "ProfileImage"
        case createdDate = "CreatedDate"
        case likeMovieIDList = "LikeMovieIDList"
        case searchTermList = "SearchTermList"
        case mbti = "MBTI"
    }
    
    private init() {}
    
    static var onboardingComplete: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.onBoardingComplete.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.onBoardingComplete.rawValue)
        }
    }
    
    @discardableResult static func getSetOnboardingComplete(newOnboardingComplete: Bool? = nil) -> Bool {
        if let newOnboardingComplete {
            UserDefaults.standard.set(newOnboardingComplete, forKey: UserDefaultsKey.onBoardingComplete.rawValue)
            return newOnboardingComplete
        } else {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.onBoardingComplete.rawValue)
        }
    }
    
    static var nickname: String {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.nickname.rawValue)
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
    
    static var profileImage: ProfileImageType {
        get {
            guard UserDefaults.standard.bool(forKey: UserDefaultsKey.onBoardingComplete.rawValue), let profileImage = ProfileImageType(rawValue: UserDefaults.standard.integer(forKey: UserDefaultsKey.profileImage.rawValue)) else {
                return ProfileImageType.getRandomCase()
            }
            return profileImage
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: UserDefaultsKey.profileImage.rawValue)
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
    
    static var createdDate: String {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKey.createdDate.rawValue) ?? Date().convertToCreatedDateString()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.createdDate.rawValue)
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
    
    static var likeMovieList: [Int] {
        get {
            return UserDefaults.standard.array(forKey: UserDefaultsKey.likeMovieIDList.rawValue) as? [Int] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.likeMovieIDList.rawValue)
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
    
    static var searchTermList: [String] {
        get {
            return UserDefaults.standard.array(forKey: UserDefaultsKey.searchTermList.rawValue) as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.searchTermList.rawValue)
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
    
    static var mbti: [String?] {
        get {
            return UserDefaults.standard.array(forKey: UserDefaultsKey.mbti.rawValue) as? [String] ?? Array(repeating: nil, count: 4)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.mbti.rawValue)
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
