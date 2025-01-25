//
//  NicknameSettingViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

final class NicknameSettingViewController: CustomBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "프로필 설정"
    }
}
