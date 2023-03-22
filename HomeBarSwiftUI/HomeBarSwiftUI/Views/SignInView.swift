//
//  SignInView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore

struct SignInView: View {

    @State private var isAuth = true

    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var checkPassword = ""
    @State private var age = ""

    @State private var isTabViewShow = false
    @State private var isShowAlert = false

    @State private var alertMessage = ""

    var body: some View {
        ZStack() {
            WallpaperView().blur(radius: isAuth ? 0 : 2)
            VStack() {
                LogoView().blur(radius: isAuth ? 0 : 4)
                Spacer()
                VStack(spacing: 20) {
                    Text(isAuth ? "Authorization" : "Registration")
                        .font(.system(size: 22))
                        .padding(.vertical, 10)
                        .padding(.horizontal, isAuth ? 16 : 32)
                        .background(Color(.white).opacity(0.2))
                        .cornerRadius(isAuth ? 16 : 32)
                        .foregroundColor(Color(.white))
                        .padding(.bottom, 30)
                    VStack(spacing: 10) {
                        TextFieldWithImageView(title: "Email",
                                               imageSystemName: "envelope.circle",
                                               text: $email)
                        SecureFieldWithImageView(title: "Password",
                                                 imageSystemName: "key",
                                                 text: $password)
                        if !isAuth {
                            SecureFieldWithImageView(title: "Repeat Password",
                                                     imageSystemName: "key.fill",
                                                     text: $checkPassword)
                            TextFieldWithImageView(title: "Name",
                                                   imageSystemName: "person.circle",
                                                   text: $name)
                            TextFieldWithImageView(title: "Your Age",
                                                   imageSystemName: "21.circle",
                                                   text: $age)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 30)
                    VStack(spacing: 4) {
                        OrangeButtonView(action: isAuth ? SignInDidTapped : SignUpDidTapped,
                                         title: isAuth ? "Sign In" : "Sign Up")
                        HStack(spacing: 10) {
                            Text(isAuth ? "Don't Have An Account?" : "Already Have An Account")
                                .foregroundColor(Color(.white).opacity(0.8))
                            BlueButtonView(action: showSingUp,
                                           title: isAuth ? "Sign Up" : "Back")
                        }
                    }
                }
                
                .padding(isAuth ? 16 : 8)
                .background(LinearGradient(colors: [Color("neonBlue"), Color("neonOrange")],
                                           startPoint: .top,
                                           endPoint: .bottom).opacity(0.15))
                .cornerRadius(isAuth ? 16 : 32)
                .clipShape(RoundedRectangle(cornerRadius: isAuth ? 16 : 32))
                .overlay(RoundedRectangle(cornerRadius: isAuth ? 16 : 32).stroke(LinearGradient(
                    colors: [Color("neonOrange"), Color("neonBlue")],
                    startPoint: .top,
                    endPoint: .bottom
                ).opacity(0.5), lineWidth: 2))
                Spacer()
            }
            .padding(8)
            .animation(Animation.easeInOut(duration: 0.4),
                       value: isAuth)
            .alert(alertMessage, isPresented: $isShowAlert) {
                Button { } label: { Text("OK") }
            }
        }
        .fullScreenCover(isPresented: $isTabViewShow) {
            if let user = AuthServices.shared.currentUser {
                let mainTabBarViewModel = MainTabBarViewModel(user: user) // если мы авторизованы то юзер там уже есть
                MainTabView(viewModel: mainTabBarViewModel)
            }
        }
    }

    private func SignInDidTapped() {
        print("User Authorization with Firebase")
        print("\(email) \(password)")
        AuthServices.shared.signIn(email: self.email,
                                   password: self.password) { result in
            switch result {
            case .success(_):
                isTabViewShow.toggle()
            case .failure(let error):
                isTabViewShow.toggle()
                alertMessage = "Sign Up Error - \(error.localizedDescription)"
                self.isShowAlert.toggle()
            }
        }

    }

    private func SignUpDidTapped() {
        print("User Registration  with Firebase")
        print("\(email) \(password)")

        guard password == checkPassword else {
            self.alertMessage = "Passwords don't match!"
            self.isShowAlert.toggle()
            return
        }

        guard Int(age) ?? 0 >= 21 else {
            self.alertMessage = "For using this application your age should be more than 21"
            self.isShowAlert.toggle()
            return
        }


        AuthServices.shared.signUp(email: self.email,
                                   password: self.password,
                                   name: self.name,
                                   age: self.age) { result in
            switch result {
            case .success(let user):
                guard let email = user.email else { return }
                self.alertMessage = "You have signed up with email \(email)!"
                self.isShowAlert.toggle()
                self.email = ""
                self.password = ""
                self.checkPassword = ""
                self.age = ""
                self.isAuth.toggle()
            case .failure(let error):
                self.alertMessage = "Sign Up Error - \(error.localizedDescription)"
                self.isShowAlert.toggle()
            }
        }
    }

    private func showSingUp() {
        isAuth.toggle()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
