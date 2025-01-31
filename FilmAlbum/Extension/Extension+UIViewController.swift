//
//  Extension+UIViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

extension UIViewController {
    func getResignAlert() -> UIAlertController {
        let ac: UIAlertController = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다.\n탈퇴 하시겠습니까?", preferredStyle: .alert)
        let confirm: UIAlertAction = UIAlertAction(title: "확인", style: .default) { _ in
            UserDataManager.resetUserData()
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
            window.rootViewController = UINavigationController(rootViewController: OnboardingViewController(viewType: .onboarding))
            window.makeKeyAndVisible()
        }
        let cancel: UIAlertAction = UIAlertAction(title: "취소", style: .cancel)
        ac.addAction(confirm)
        ac.addAction(cancel)
        
        return ac
    }
    
    func setNavigationItemSearchBar() {
        let sc: UISearchController = UISearchController()
        sc.hidesNavigationBarDuringPresentation = false
        sc.automaticallyShowsCancelButton = false
        sc.searchBar.searchTextField.tintColor = UIColor.faWhite
        sc.searchBar.searchTextField.leftView?.tintColor = UIColor.faWhite
        sc.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "검색어를 입력하세요.", attributes: [.foregroundColor: UIColor.faGray])
        sc.searchBar.searchTextField.backgroundColor = .faDarkGray
        
        DispatchQueue.main.async {
            sc.searchBar.searchTextField.textColor = UIColor.faWhite
        }
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = sc
    }
}
