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

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform()
}

final class ProfileSettingViewModel: BaseViewModel {
    struct Input {
        let profileImageData: Observer<ProfileImageType> = Observer(value: UserDataManager.getSetProfileImage())
        let profileImageViewTapped: Observer<Void> = Observer(value: ())
        let profileNicknameCheck: Observer<String?> = Observer(value: UserDataManager.getSetNickname())
        let mbtiData: Observer<Array<String?>> = Observer(value: UserDataManager.getSetMBTI())
        let profileSave: Observer<Void> = Observer(value: ())
    }
    struct Output {
        let profileImageData: Observer<ProfileImageType> = Observer(value: UserDataManager.getSetProfileImage())
        let profileImageViewTapped: Observer<ProfileImageType> = Observer(value: UserDataManager.getSetProfileImage())
        let profileNicknameCheck: Observer<NicknameCheckState> = Observer(value: NicknameCheckState.charCountError)
        let mbtiData: Observer<Array<String?>> = Observer(value: UserDataManager.getSetMBTI())
        let profileSaveButtonState: Observer<Bool> = Observer(value: false)
        let profileSave: Observer<Void> = Observer(value: ())
    }

    private(set) var input: Input = Input()
    private(set) var output: Output = Output()
    
    init() {
        self.transform()
    }
    
    func transform() {
        self.input.profileImageData.bind { [weak self] _, nV in
            self?.output.profileImageData.value = nV
        }
        self.input.profileImageViewTapped.closure = { [weak self] _, _ in
            self?.output.profileImageViewTapped.value = self?.input.profileImageData.value ?? UserDataManager.getSetProfileImage()
        }
        self.input.profileNicknameCheck.closure = { [weak self] _, nV in
            self?.output.profileNicknameCheck.value = self?.checkProfileNickname(text: nV) ?? NicknameCheckState.charCountError
            self?.checkProfileSaveButtonState()
        }
        self.input.mbtiData.closure = { [weak self] _, nV in
            self?.output.mbtiData.value = nV
            self?.checkProfileSaveButtonState()
        }
        self.input.profileSave.closure = { [weak self] _, _ in
            UserDataManager.getSetOnboardingComplete(newOnboardingComplete: true)
            UserDataManager.getSetNickname(newNickname: self?.input.profileNicknameCheck.value)
            UserDataManager.getSetProfileImage(newProfileImageType: self?.input.profileImageData.value)
            UserDataManager.getSetCreatedDateString(newCreatedDate: Date())
            UserDataManager.getSetMBTI(newMBTI: self?.input.mbtiData.value ?? [])
            self?.output.profileSave.value = ()
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
        if self.input.mbtiData.value.contains(nil) {
            return false
        } else {
            return true
        }
    }
    
    private func checkProfileSaveButtonState() {
        if self.checkMBTI() && self.checkProfileNickname(text: self.input.profileNicknameCheck.value) == .ok {
            self.output.profileSaveButtonState.value = true
        } else {
            self.output.profileSaveButtonState.value = false
        }
    }
}
