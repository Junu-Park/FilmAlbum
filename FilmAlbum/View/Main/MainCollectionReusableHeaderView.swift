//
//  MainCollectionReusableHeaderView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/29/25.
//

import UIKit

import SnapKit

final class MainCollectionReusableHeaderView: UICollectionReusableView {
    
    static let id: String = "MainCollectionReusableHeaderView"
    
    static let height: CGFloat = 50
    
    private let titleLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa16BoldFont
        return lb
    }()
    
    private let allDeleteButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setAttributedTitle(NSAttributedString(string: "전체 삭제", attributes: [.foregroundColor: UIColor.faAccent, .font: UIFont.fa16BoldFont]), for: .normal)
        btn.setAttributedTitle(NSAttributedString(string: "전체 삭제", attributes: [.foregroundColor: UIColor.faLightGray, .font: UIFont.fa16BoldFont]), for: .highlighted)
        return btn
    }()
    
    var headerType: MainHeaderType = .recentSearchTerm {
        didSet {
            self.titleLabel.text = self.headerType.rawValue
            
            if self.headerType == .recentSearchTerm {
                addSubview(self.allDeleteButton)
                
                self.allDeleteButton.snp.makeConstraints { make in
                    make.trailing.equalToSuperview().offset(-16)
                    make.centerY.equalToSuperview()
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
