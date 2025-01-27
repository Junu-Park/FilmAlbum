//
//  Extension+String?.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/27/25.
//

import Foundation

extension String? {
    func checkNicknameValidation() -> NicknameTextFieldState {
        if let self, (2...10).contains(self.count) {
            if self.filter(\.isNumber).count > 0 {
                return NicknameTextFieldState.numberCharError
            }
            if self.contains(where: { ["@", "#", "$", "%"].contains($0) }) {
                return NicknameTextFieldState.specialCharError
            }
            return NicknameTextFieldState.ok
        } else {
            return NicknameTextFieldState.charCountError
        }
    }
}
