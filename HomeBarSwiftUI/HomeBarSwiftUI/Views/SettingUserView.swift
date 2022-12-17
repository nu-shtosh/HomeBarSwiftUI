//
//  SettingUserView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 16.12.2022.
//

import SwiftUI

struct SettingUserView: View {
    @StateObject var profileViewModel: ProfileViewModel
    
    
    var body: some View {
        ZStack {
            WallpaperView()
            VStack {
                ZStack {
                    UserImageView()
                    Button(action: {}) {
                        Image(systemName:"photo.fill")
                            .resizable()
                            .frame(width: 40, height: 35)
                            .foregroundColor(Color("neonOrange"))
                            .offset(x: 100 , y: -30)
                            
                    }
                }
                Spacer()
                TextFieldWithImageView(title: "Name", imageSystemName: "", text: $profileViewModel.profile.name)
                TextFieldWithImageView(title: "Surename", imageSystemName: "", text: $profileViewModel.profile.surname)
                TextFieldWithImageView(title: "Age", imageSystemName: "", text: $profileViewModel.profile.age)
                Spacer()
                OrangeButtonView(action: profileViewModel.setProfile, title: "Save")
                Spacer()
                
                
            }
            .padding()
            
        }
        .onSubmit {
            profileViewModel.setProfile()
        }
        .navigationTitle("Setting")
    }
        
}

struct SettingUserView_Previews: PreviewProvider {
    static var previews: some View {
        SettingUserView(profileViewModel: ProfileViewModel(profile: UserDB(id: "", name: "", surname: "", age: "")))
    }
}
