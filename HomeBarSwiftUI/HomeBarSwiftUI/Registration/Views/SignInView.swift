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


    @State var isAuth = true

    @State var email = ""
    @State var password = ""
    @State var checkPassword = ""

    @State var message = ""
    @State var alert = false
    @State var show = false

    var body: some View {
            ZStack() {
                WallpaperView()
                    .blur(radius: isAuth ? 0 : 2)
                VStack() {
                    LogoView()
                        .blur(radius: isAuth ? 0 : 4)
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
                        TextFieldWithImageView(title: "Email", imageSystemName: "envelope", text: $email)
                        SecureFieldWithImageView(title: "Password", imageSystemName: "key", text: $password)
                            if !isAuth {
                                SecureFieldWithImageView(title: "Repeat Password", imageSystemName: "key.fill", text: $password)
                            }
                        }.padding(.bottom, 30)
                        VStack(spacing: 4) {
                            OrangeButtonView(action: isAuth ? SignInDidTapped : SignUpDidTapped, title: isAuth ? "Sign In" : "Sign Up")
                                .alert(isPresented: $alert) {
                                    Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("OK")))
                                }
                            HStack(spacing: 10) {
                                Text(isAuth ? "Don't Have An Account?" : "Already Have An Account!")
                                    .foregroundColor(Color(.white).opacity(0.8))
                                BlueButtonView(action: showSingUp, title: isAuth ? "Sign Up" : "Back")
                            }
                        }
                    }
                    .padding(isAuth ? 16 : 8)
                    .background(Color(.white).opacity(0.2))
                    .cornerRadius(isAuth ? 16 : 32)
                    Spacer()
                }
                .animation(Animation.easeInOut(duration: 0.4), value: isAuth)
                .padding(8)
            }
        }

    func SignInDidTapped() {
        print("Authorization")
    }

    func SignUpDidTapped() {
        print("Registration")
    }

    func showSingUp() {
        isAuth.toggle()
    }
}


func logInWithEmail(email: String, password: String, completion: @escaping (Bool, String) -> Void ) {
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
        if error != nil {
            completion(false, (error?.localizedDescription ?? "No error description!"))
            return
        }
        completion(true, (result?.user.email)!)
    }
}



struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
