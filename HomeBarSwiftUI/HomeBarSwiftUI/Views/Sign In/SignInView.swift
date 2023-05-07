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

    // MARK: - State Properties
    @State private var isAuth = true
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var checkPassword = ""
    @State private var age = ""
    @State private var isTabViewShow = false
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    // MARK: - FocusState Properties
    @FocusState private var currentTag: Tags?

    var body: some View {
        ZStack() {
            // MARK: - Wallpaper View
            WallpaperView().blur(radius: isAuth ? 0 : 2)

            ScrollView {
                VStack {
                    // MARK: - Logo View
                    LogoView().blur(radius: isAuth ? 0 : 4)

                    Spacer()

                    // MARK: - TextFields
                    VStack(spacing: 15) {

                        // MARK: - Authorization / Registration TextField
                        Text(isAuth ? "Authorization" : "Registration")
                            .font(.system(size: 22))
                            .padding(.vertical, 10)
                            .padding(.horizontal, isAuth ? 16 : 32)
                            .background(Color(.white).opacity(0.2))
                            .cornerRadius(isAuth ? 16 : 32)
                            .foregroundColor(Color(.white))
                            .padding(.bottom, 10)

                        VStack(spacing: 10) {

                            // MARK: - Email TextField
                            TextFieldWithImageView(title: "Email",
                                                   imageSystemName: "envelope.circle",
                                                   text: $email)
                            .keyboardType(.emailAddress)
                            .focused($currentTag, equals: .one)
                            .submitLabel(.next)
                            .onSubmit {
                                nextField()
                            }

                            // MARK: - Password SecureField
                            SecureFieldWithImageView(title: "Password",
                                                     imageSystemName: "key",
                                                     text: $password)
                            .focused($currentTag, equals: .two)
                            .submitLabel(isAuth ? .done : .next)
                            .onSubmit {
                                nextField()
                            }

                            if !isAuth {
                                // MARK: - Repeat Password SecureField
                                SecureFieldWithImageView(title: "Repeat Password",
                                                         imageSystemName: "key.fill",
                                                         text: $checkPassword)
                                .focused($currentTag, equals: .three)
                                .submitLabel(.next)
                                .onSubmit {
                                    nextField()
                                }

                                // MARK: - Name TextField
                                TextFieldWithImageView(title: "Name",
                                                       imageSystemName: "person.circle",
                                                       text: $name)
                                .focused($currentTag, equals: .four)
                                .submitLabel(.next)
                                .onSubmit {
                                    nextField()
                                }

                                // MARK: - Age TextField
                                TextFieldWithImageView(title: "Your Age",
                                                       imageSystemName: "21.circle",
                                                       text: $age)
                                .keyboardType(.numbersAndPunctuation)
                                .focused($currentTag, equals: .five)
                                .submitLabel(.done)
                                .onSubmit {
                                    SignInDidTapped()
                                }
                            } // End If
                        } // End VStack
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))

                        // MARK: - Buttons
                        VStack(spacing: 4) {

                            // MARK: - Sign In / Sign Up Button
                            OrangeButtonView(action: isAuth ? SignInDidTapped : SignUpDidTapped,
                                             title: isAuth ? "Sign In" : "Sign Up")

                            // MARK: - Sign In / Sign Up Change View Button
                            HStack(spacing: 10) {
                                Text(isAuth ? "Don't Have An Account?" : "Already Have An Account")
                                    .foregroundColor(Color(.white).opacity(0.8))
                                BlueButtonView(action: showSingUp,
                                               title: isAuth ? "Sign Up" : "Sign In")
                            } // End HStack
                        } // End VStack
                    } // End VStack
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
                } // End VStack
                .padding(8)
                .animation(Animation.easeInOut(duration: 0.5),
                           value: isAuth)
                .alert(alertMessage, isPresented: $isShowAlert) {
                    Button { } label: { Text("OK") }
                }
            } // End ScrollView
            .fullScreenCover(isPresented: $isTabViewShow) {
                if let user = AuthServices.shared.currentUser {
                    let mainTabBarViewModel = MainTabBarViewModel(user: user)
                    MainTabView(isActive: $isTabViewShow, tabBarViewModel: mainTabBarViewModel)
                }
            }
            .onTapGesture {
                self.endTextEditing()
            }
        } // End ZStack
    } // End Body

    // MARK: - Sign In Did Tapped Button
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
                alertMessage = "Sign In Error - \(error.localizedDescription)"
                self.isShowAlert.toggle()
            }
        }

    }

    // MARK: - Sign Up Did Tapped Button
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

    // MARK: - Toggling Auth
    private func showSingUp() {
        isAuth.toggle()
    }
}

// MARK: - Extension For Switching TextField (Next Button On Keyboard)
extension SignInView {
    enum Tags {
        case one, two, three, four, five
    }

    private func nextField() {
        switch currentTag {
        case .one: currentTag = .two
        case .two: currentTag = .three
        case .three: currentTag = .four
        case .four: currentTag = .five
        case .five: currentTag = .one
        case .none: currentTag = nil
        }
    }
}
