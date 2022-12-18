//
//  ProfileViewModel.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 17.12.2022.
//

import Foundation
import UIKit

class ProfileViewModel: ObservableObject {
    @Published var profile: UserDB
    @Published var image = UIImage(named: "photo")!
    
    init(profile: UserDB) {
        self.profile = profile
    }
    
    func setProfile() {
        DataBaseService.shared.setProfile(user: self.profile, image: nil) { result in
            switch result {
            case .success(let user):
                print(user.name)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getProfile() {
        DataBaseService.shared.getProfile { result in
            switch result {
            case .success(let user):
                self.profile = user
                self.getImage()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getImage() {
        StorageService.shared.downloadUserImage(id: profile.id) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.image = image
                    print("ok image")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
