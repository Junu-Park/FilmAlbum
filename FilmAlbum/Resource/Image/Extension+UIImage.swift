//
//  Extension+UIImage.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

extension UIImage {
    static var faCameraFill: UIImage {
        return UIImage(systemName: "camera.fill") ?? UIImage()
    }
    static var faMagnifyingglass: UIImage {
        return UIImage(systemName: "magnifyingglass") ?? UIImage()
    }
    static var faXmark: UIImage {
        return UIImage(systemName: "xmark") ?? UIImage()
    }
    static var faCalendar: UIImage {
        return UIImage(systemName: "calendar") ?? UIImage()
    }
    static var faHeart: UIImage {
        return UIImage(systemName: "heart") ?? UIImage()
    }
    static var faHeartFill: UIImage {
        return UIImage(systemName: "heart.fill") ?? UIImage()
    }
    static var faStarFill: UIImage {
        return UIImage(systemName: "star.fill") ?? UIImage()
    }
    static var faFilmFill: UIImage {
        return UIImage(systemName: "film.fill") ?? UIImage()
    }
    
    static func getProfileImage(number num : Int) -> UIImage {
        return UIImage(named: ProfileImage(rawValue: num)?.getImageName() ?? "") ?? UIImage()
    }
}
