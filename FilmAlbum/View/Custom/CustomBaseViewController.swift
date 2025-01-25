//
//  CustomBaseViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/25/25.
//

import UIKit

enum ViewType {
    case onboarding
    case main
    case nicknameSetting
    case imageSetting
    case search
    case searchDetail(movieTitle: String)
    
    var title: String {
        switch self {
        case .onboarding:
            return ""
        case .main:
            return "FilmAlbum"
        case .nicknameSetting:
            return "프로필 설정"
        case .imageSetting:
            return "프로필 이미지 설정"
        case .search:
            return "영화 검색"
        case .searchDetail(let movieTitle):
            return movieTitle
        }
    }
}

class CustomBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonDisplayMode = .minimal
    }
    
    init(viewType: ViewType) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = viewType.title
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
