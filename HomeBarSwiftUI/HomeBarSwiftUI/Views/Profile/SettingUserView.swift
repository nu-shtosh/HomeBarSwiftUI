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
    @State private var showAlert = false
    @State private var showProgressView = false
    @Binding var shouldPopToRootView : Bool
    @Environment (\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                .padding(.bottom, 20)
                OrangeButtonView(action: uploadData, title: "Save")
                    .padding(.bottom, 40)
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Delete account")
                        .font(.system(size: 22))
                }
                .frame(width: 300, height: 50)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                Spacer()

            }
            .padding()
            .disabled(showProgressView)
            .blur(radius: showProgressView ? 3 : 0)
            if showProgressView {
                ActivityIndicator()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("neonBlue"))
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Are you sure you want to delete your account?"),
                message: Text("Without an account you cannot use the application!"),
                primaryButton: .default(Text("Delete")) {
                    AuthServices.shared.deleteUser()
                    shouldPopToRootView = true
                    dismiss.callAsFunction()
                },
                secondaryButton: .default(Text("Cancel"))
            )
        }
        .onSubmit {
            profileViewModel.setProfile()
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Setting")
        
    }
    
    private func uploadData() {
        showProgressView = true
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
