//
//  Extension+UIImage.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

enum AFImage {
    static var afCameraFill: UIImage {
        return UIImage(systemName: "camera.fill") ?? UIImage()
    }
    static var afMagnifyingglass: UIImage {
        return UIImage(systemName: "magnifyingglass") ?? UIImage()
    }
    static var afXmark: UIImage {
        return UIImage(systemName: "xmark") ?? UIImage()
    }
    static var afCalendar: UIImage {
        return UIImage(systemName: "calendar") ?? UIImage()
    }
    static var afHeart: UIImage {
        return UIImage(systemName: "heart") ?? UIImage()
    }
    static var afHeartFill: UIImage {
        return UIImage(systemName: "heart.fill") ?? UIImage()
    }
    static var afStarFill: UIImage {
        return UIImage(systemName: "star.fill") ?? UIImage()
    }
    static var afFilmFill: UIImage {
        return UIImage(systemName: "film.fill") ?? UIImage()
    }
}
