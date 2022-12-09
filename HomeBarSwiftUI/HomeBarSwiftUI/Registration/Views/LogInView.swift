//
//  LogInView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI

struct LogInView: View {

    @State var email = ""
    @State var password = ""

    var body: some View {
        ZStack() {
            WallpaperView()
            VStack() {
                LogoView()
                Spacer()
                VStack(spacing: 15) {
                    TextFieldWithImageView(title: "Email", imageSystemName: "envelope", text: $email)
                    SecureFieldWithImageView(title: "Password", imageSystemName: "key", text: $password)
                }.padding()
                Spacer()
                OrangeButtonView(action: logInDidTapped(), title: "Log In")
                BlueButtonView(action: signUpDidTapped(), title: "Sign Up")
                    .padding(.top, 10)
                Spacer(minLength: 150)
            }
        }
    }

    func logInDidTapped() {
    }

    func signUpDidTapped() {
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
