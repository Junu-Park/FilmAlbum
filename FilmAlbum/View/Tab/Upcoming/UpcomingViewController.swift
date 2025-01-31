//
//  UpcomingViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

import SnapKit

final class UpcomingViewController: CustomBaseViewController {

    private let tempLabel: UILabel = {
        let lb: UILabel = UILabel()
        lb.font = UIFont.fa16BoldFont
        lb.text = "Coming Soon"
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tempLabel)
        
        self.tempLabel.snp.makeConstraints { make in
            make.center.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
