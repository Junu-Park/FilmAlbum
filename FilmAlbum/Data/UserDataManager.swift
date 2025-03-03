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
    
    static var nickname: String {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.nickname.rawValue)
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
    
    static var createdDate: String {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKey.createdDate.rawValue) ?? Date().convertToCreatedDateString()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.createdDate.rawValue)
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
    
    static var searchTermList: [String] {
        get {
            return UserDefaults.standard.array(forKey: UserDefaultsKey.searchTermList.rawValue) as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.searchTermList.rawValue)
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
    
    static func resetUserData() {
        UserDefaultsKey.allCases.forEach { key in
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
    
    static func resetSearchTermList() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.searchTermList.rawValue)
    }
}
