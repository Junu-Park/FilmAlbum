//
//  ProfileSettingViewModel.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/7/25.
//

import UIKit

enum NicknameCheckState: String {
    
    case ok = "사용할 수 있는 닉네임이에요"
    case charCountError = "2글자 이상 10글자 미만으로 설정해주세요"
    case specialCharError = "닉네임에 @, #, $, % 는 포함할 수 없어요"
    case numberCharError = "닉네임에 숫자는 포함할 수 없어요"
    
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

enum MBTIType: String, CaseIterable {
    case EI = "EI"
    case SN = "SN"
    case TF = "TF"
    case JP = "JP"
    
    var getMBTIStringList: [String.Element] {
        return Array(self.rawValue)
    }
}

final class ProfileSettingViewModel {
    
    let profileImageDataIn: Observer<ProfileImageType> = Observer(value: UserDataManager.getSetProfileImage())
    lazy var profileImageDataOut: Observer<ProfileImageType> = Observer(value: self.profileImageDataIn.value)
    
    let profileImageViewTappedIn: Observer<Void> = Observer(value: ())
    lazy var profileImageViewTappedOut: Observer<ProfileImageType> = Observer(value: self.profileImageDataIn.value)
    
    let profileNicknameCheckIn: Observer<String?> = Observer(value: UserDataManager.getSetNickname())
    let profileNicknameCheckOut: Observer<NicknameCheckState> = Observer(value: NicknameCheckState.charCountError)
    
    let mbtiDataIn: Observer<Array<String?>> = Observer(value: Array(repeating: nil, count: 4))
    lazy var mbtiDataOut: Observer<Array<String?>> = Observer(value: self.mbtiDataIn.value)
    
    let profileSaveButtonStateOut: Observer<Bool> = Observer(value: false)
    
    let profileSaveIn: Observer<Void> = Observer(value: ())
    let profileSaveOut: Observer<Void> = Observer(value: ())
    
    init() {
        self.profileImageDataIn.closure = { [weak self] _, nV in
            self?.profileImageDataOut.value = nV
        }
        self.profileImageViewTappedIn.closure = { [weak self] _, _ in
            self?.profileImageViewTappedOut.value = self?.profileImageDataIn.value ?? UserDataManager.getSetProfileImage()
        }
        self.profileNicknameCheckIn.closure = { [weak self] _, nV in
            self?.profileNicknameCheckOut.value = self?.checkProfileNickname(text: nV) ?? NicknameCheckState.charCountError
            self?.checkProfileSaveButtonState()
        }
        self.mbtiDataIn.closure = { [weak self] _, nV in
            self?.mbtiDataOut.value = nV
            self?.checkProfileSaveButtonState()
        }
        self.profileSaveIn.closure = { [weak self] _, _ in
            UserDataManager.getSetOnboardingComplete(newOnboardingComplete: true)
            UserDataManager.getSetNickname(newNickname: self?.profileNicknameCheckIn.value)
            UserDataManager.getSetProfileImage(newProfileImageType: self?.profileImageDataIn.value)
            UserDataManager.getSetCreatedDateString(newCreatedDate: Date())
            self?.profileSaveOut.value = ()
        }
    }
    
    private func checkProfileNickname(text: String?) -> NicknameCheckState {
        if let text, (2...10).contains(text.count) {
            if text.filter(\.isNumber).count > 0 {
                return NicknameCheckState.numberCharError
            }
            if text.contains(where: { ["@", "#", "$", "%"].contains($0) }) {
                return NicknameCheckState.specialCharError
            }
            return NicknameCheckState.ok
        } else {
            return NicknameCheckState.charCountError
        }
    }
    
    private func checkMBTI() -> Bool {
        if self.mbtiDataIn.value.contains(nil) {
            return false
        } else {
            return true
        }
    }
    
    private func checkProfileSaveButtonState() {
        if self.checkMBTI() && self.profileNicknameCheckOut.value == .ok {
            self.profileSaveButtonStateOut.value = true
        } else {
            self.profileSaveButtonStateOut.value = false
        }
    }
}
