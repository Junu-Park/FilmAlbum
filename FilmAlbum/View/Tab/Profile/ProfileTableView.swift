//
//  ProfileTableView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

enum SettingType: CaseIterable {
    case faq
    case oneToOne
    case noti
    case resign
    
    var title: String {
        switch self {
        case .faq:
            return "자주 묻는 질문"
        case .oneToOne:
            return "1:1 문의"
        case .noti:
            return "알림 설정"
        case .resign:
            return "탈퇴"
        }
    }
}

final class ProfileTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.backgroundColor = UIColor.faBlack
        self.separatorColor = UIColor.faLightGray
        self.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        self.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.id)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
