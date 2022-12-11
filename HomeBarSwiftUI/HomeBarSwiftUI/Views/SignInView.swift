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
    @State private var checkPassword = ""

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
                                               imageSystemName: "envelope",
                                               text: $email)
                        SecureFieldWithImageView(title: "Password",
                                                 imageSystemName: "key",
                                                 text: $password)
                        if !isAuth {
                            SecureFieldWithImageView(title: "Repeat Password",
                                                     imageSystemName: "key.fill",
                                                     text: $checkPassword)
                        }
                    }.padding(.bottom, 30)
                    VStack(spacing: 4) {
                        OrangeButtonView(action: isAuth ? SignInDidTapped : SignUpDidTapped,
                                         title: isAuth ? "Sign In" : "Sign Up")
                        HStack(spacing: 10) {
                            Text(isAuth ? "Don't Have An Account?" : "Already Have An Account!")
                                .foregroundColor(Color(.white).opacity(0.8))
                            BlueButtonView(action: showSingUp,
                                           title: isAuth ? "Sign Up" : "Back")
                        }
                    }
                }
                .padding(isAuth ? 16 : 8)
                .background(Color(.white).opacity(0.2))
                .cornerRadius(isAuth ? 16 : 32)
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
            MainTabView()
        }
    }

    private func SignInDidTapped() {
        print("User Authorization with Firebase")
        print("\(email) \(password)")
        isTabViewShow.toggle()
    }

    private func SignUpDidTapped() {
        print("User Registration  with Firebase")
        print("\(email) \(password)")

        guard password == checkPassword else {
            self.alertMessage = "Passwords don't match!"
            isShowAlert.toggle()
            return
        }

        AuthServices.shared.SignUp(email: self.email,
                                   password: self.password) { result in
            switch result {
            case .success(let user):
                guard let email = user.email else { return }
                alertMessage = "You have signed up with email \(email)!"
                self.isShowAlert.toggle()
                self.email = ""
                self.password = ""
                self.checkPassword = ""
                isAuth.toggle()
            case .failure(let error):
                alertMessage = "Sign Up Error - \(error.localizedDescription)"
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
