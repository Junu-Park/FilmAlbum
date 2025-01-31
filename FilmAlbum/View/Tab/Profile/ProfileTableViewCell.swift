//
//  ProfileTableViewCell.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/31/25.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell {

    static let id: String = "ProfileTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.faBlack
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContentText(_ text: String) {
        var content: UIListContentConfiguration = self.defaultContentConfiguration()
        content.text = text
        content.textProperties.font = UIFont.fa16Font
        content.textProperties.color = UIColor.faWhite
        self.contentConfiguration = content
    }
}
