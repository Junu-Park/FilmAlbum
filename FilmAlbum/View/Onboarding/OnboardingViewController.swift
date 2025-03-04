//
//  OnboardingViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

final class OnboardingViewController: CustomBaseViewController {

    private let contentView: OnboardingView = OnboardingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = contentView
        self.contentView.startButton.addTarget(self, action: #selector(self.startButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startButtonTapped() {
        self.navigationController?.pushViewController(NicknameViewController(viewType: .nicknameSetting), animated: true)
    }
}
