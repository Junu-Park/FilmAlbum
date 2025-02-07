//
//  Extension+UIImage.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

extension UIImage {
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
    static var faPopcorn: UIImage {
        return UIImage(systemName: "popcorn") ?? UIImage()
    }
    static var faFilm: UIImage {
        return UIImage(systemName: "film") ?? UIImage()
    }
    static var faProfile: UIImage {
        return UIImage(systemName: "person.crop.circle") ?? UIImage()
    }
    static var faCameraFill: UIImage {
        return UIImage(systemName: "camera.fill") ?? UIImage()
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
    static var faPopcornFill: UIImage {
        return UIImage(systemName: "popcorn.fill") ?? UIImage()
    }
    static var faProfileFill: UIImage {
        return UIImage(systemName: "person.crop.circle.fill") ?? UIImage()
    }
    
    static func getProfileImageWithRawValue(number num : Int) -> UIImage {
        return UIImage(named: ProfileImageType(rawValue: num)?.imageName ?? "") ?? UIImage()
    }
    
    static func getProfileImageWithName(name: String) -> UIImage {
        return UIImage(named: name) ?? UIImage()
    }
}
