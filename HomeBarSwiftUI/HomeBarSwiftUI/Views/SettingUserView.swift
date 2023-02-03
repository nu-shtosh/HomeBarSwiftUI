//
//  SettingUserView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 16.12.2022.
//

import SwiftUI

struct SettingUserView: View {
    
    @StateObject var profileViewModel: ProfileViewModel
    @State private var showImagePicker = false
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            WallpaperView()
            VStack {
                ZStack {
                    UserImageView(image: $profileViewModel.image)
                        .onTapGesture {
                            showImagePicker.toggle()
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(
                                sourceType: .photoLibrary,
                                selected: $profileViewModel.image
                            )
                        }
                }
                Spacer()
                TextFieldWithImageView(
                    title: "Name",
                    imageSystemName: "person.fill",
                    text: $profileViewModel.profile.name
                )
                TextFieldWithImageView(
                    title: "Surename",
                    imageSystemName: "person.circle",
                    text: $profileViewModel.profile.surname
                )
                TextFieldWithImageView(
                    title: "Age",
                    imageSystemName: "person.crop.circle.badge.clock",
                    text: $profileViewModel.profile.age
                )
                Spacer()
                OrangeButtonView(action: uploadData, title: "Save")
                Spacer()
            }
            .padding()
        }
        .onSubmit {
            profileViewModel.setProfile()
        }
        .navigationTitle("Setting")
    }
    
    private func uploadData() {
        let user = profileViewModel.profile
        guard let imageData = profileViewModel.image.jpegData(compressionQuality: 0.1) else {
            return
        }
        DataBaseService.shared.setProfile(user: user, image: imageData) { result  in
            switch result {
            case .success(_):
                dismiss()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct SettingUserView_Previews: PreviewProvider {
    static var previews: some View {
        SettingUserView(profileViewModel: ProfileViewModel(profile: UserDB(
            id: "",
            name: "",
            surname: "",
            age: ""
        )))
    }
}
