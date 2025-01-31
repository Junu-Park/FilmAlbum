//
//  ProfileViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

import SnapKit

final class ProfileViewController: CustomBaseViewController {
    
    private let profileBannerView: ProfileBannerView = ProfileBannerView()
    
    private let profileTableView: ProfileTableView = ProfileTableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureConnectionTableView()
        self.profileBannerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.profileBannerTapped)))
        
        self.view.addSubview(self.profileBannerView)
        self.view.addSubview(self.profileTableView)
        
        self.profileBannerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(150)
        }
        self.profileTableView.snp.makeConstraints { make in
            make.top.equalTo(self.profileBannerView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func profileBannerTapped() {
        let nc = UINavigationController(rootViewController: NicknameViewController(viewType: .nicknameEditing))
        nc.sheetPresentationController?.prefersGrabberVisible = true
        self.present(nc, animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureConnectionTableView() {
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.profileTableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as? ProfileTableViewCell {
            cell.setContentText(SettingType.allCases[indexPath.row].title)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            present(self.getResignAlert(), animated: true)
        }
    }
}
