//
//  MainTabBarController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

enum TabBar {
    case cinema
    case upcoming
    case profile
    
    func getTabBarItem() -> UITabBarItem {
        switch self {
        case .cinema:
            return UITabBarItem(title: "CINEMA", image: UIImage.faPopcorn, selectedImage: UIImage.faPopcornFill)
        case .upcoming:
            return UITabBarItem(title: "UPCOMING", image: UIImage.faFilm, selectedImage: UIImage.faFilmFill)
        case .profile:
            return UITabBarItem(title: "PROFILE", image: UIImage.faProfile, selectedImage: UIImage.faProfileFill)
        }
    }
}

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tab1: UINavigationController = UINavigationController(rootViewController: CinemaViewController(viewType: .cinema))
        tab1.view.backgroundColor = UIColor.faBlack
        tab1.tabBarItem = TabBar.cinema.getTabBarItem()
        
        let tab2: UINavigationController = UINavigationController(rootViewController: UpcomingViewController(viewType: .upcoming))
        tab2.view.backgroundColor = UIColor.faBlack
        tab2.tabBarItem = TabBar.upcoming.getTabBarItem()
        
        let tab3: UINavigationController = UINavigationController(rootViewController: ProfileViewController(viewType: .setting))
        tab3.view.backgroundColor = UIColor.faBlack
        tab3.tabBarItem = TabBar.profile.getTabBarItem()
        
        self.setViewControllers([tab1, tab2, tab3], animated: false)
        
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor.faBlack
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}
