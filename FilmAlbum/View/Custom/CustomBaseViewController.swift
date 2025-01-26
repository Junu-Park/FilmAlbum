//
//  CustomBaseViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/25/25.
//

import UIKit

enum ViewType: Equatable {
    case onboarding
    case main
    case nicknameSetting
    case nicknameEditing
    case imageSetting
    case imageEditing
    case search
    case searchDetail(movieTitle: String)
    case setting
    
    var navigationItemTitle: String {
        switch self {
        case .onboarding:
            return ""
        case .main:
            return "FilmAlbum"
        case .nicknameSetting:
            return "프로필 설정"
        case .nicknameEditing:
            return "프로필 편집"
        case .imageSetting:
            return "프로필 이미지 설정"
        case .imageEditing:
            return "프로필 이미지 편집"
        case .search:
            return "영화 검색"
        case .searchDetail(let movieTitle):
            return movieTitle
        case .setting:
            return "설정"
        }
    }
}

class CustomBaseViewController: UIViewController {

    var viewType: ViewType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewType: ViewType) {
        super.init(nibName: nil, bundle: nil)
        self.viewType = viewType
        setNavigationItem()
    }
    
    private func setNavigationItem() {
        self.navigationItem.backButtonDisplayMode = .minimal
        self.navigationItem.title = self.viewType.navigationItemTitle
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
