//
//  ProfileSettingViewModel.swift
//  FilmAlbum
//
//  Created by 박준우 on 2/7/25.
//

import Foundation

final class ProfileSettingViewModel {
    let profileImageViewTappedIn: Observer<Void> = Observer(value: ())
    let profileImageViewTappedOut: Observer<Void> = Observer(value: ())
    
    init() {
        self.profileImageViewTappedIn.closure = { _, _ in
            self.profileImageViewTappedOut.value = ()
        }
    }
}
