//
//  ProfileImageViewController.swift
//  FilmAlbum
//
//  Created by 박준우 on 1/24/25.
//

import UIKit

final class ProfileImageViewController: CustomBaseViewController {

    lazy var settingView: ProfileImageSettingView = ProfileImageSettingView(selectedProfileImageType: self.selectedProfileImageType)
    
    lazy var editingView: ProfileImageEditingView = ProfileImageEditingView(selectedProfileImageType: self.selectedProfileImageType)
    
    private lazy var selectedProfileImageType: ProfileImageType = ProfileImageType.profile0 {
        didSet {
            if self.viewType == .imageSetting {
                self.settingView.selectedProfileImageType = self.selectedProfileImageType
            } else if self.viewType == .imageEditing {
                self.editingView.selectedProfileImageType = self.selectedProfileImageType
            } else {
                print(#function, "viewType error")
            }
        }
    }
    
    init(viewType: ViewType , selectedProfileImageType: ProfileImageType) {
        super.init(viewType: viewType)
        self.selectedProfileImageType = selectedProfileImageType
        self.settingView.selectedProfileImageType = self.selectedProfileImageType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        if self.viewType == .imageSetting {
            self.view = self.settingView
        } else if self.viewType == .imageEditing {
            self.view = self.editingView
        } else {
            print(#function, "viewType error")
        }
    }
}
