//
//  Extension+UserDefaults.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import Foundation

extension UserDefaults {
    @discardableResult static func isCompletedOnboarding(newValue value: Bool? = nil) -> Bool {
        if let value {
            self.standard.set(value, forKey: "Onboarding")
            return value
        } else {
            return self.standard.bool(forKey: "Onboarding")
        }
    }
}
