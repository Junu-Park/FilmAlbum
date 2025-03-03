//
//  OnboardingView.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

import SnapKit

final class OnboardingView: CustomBaseView {
    
    private let onboardingImageView: UIImageView = {
        let iv: UIImageView = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage.onboarding
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa32BoldFont
        lb.textAlignment = .center
        lb.text = "Onboarding"
        return lb
    }()
    
    private let subTitleLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa16Font
        lb.textAlignment = .center
        lb.text = "당신만의 영화 세상,\nFilmAlbum을 시작해보세요."
        lb.numberOfLines = 2
        return lb
    }()
    
    let startButton: UIButton = RadiusBorderButton(title: "시작하기", radius: 25, isBorder: true)
    
    override init() {
        super.init()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureHierarchy() {
        self.addSubview(onboardingImageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(startButton)
    }
    
    private func configureLayout() {
        self.onboardingImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.width.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.onboardingImageView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.startButton.snp.makeConstraints { make in
            make.top.equalTo(self.subTitleLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}
