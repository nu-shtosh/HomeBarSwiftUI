//
//  ProfileViewModel.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 17.12.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var profile: UserDB
    
    init(profile: UserDB) {
        self.profile = profile
    }
    
    func setProfile() {
        DataBaseService.shared.setProfile(user: self.profile) { result in
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
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
