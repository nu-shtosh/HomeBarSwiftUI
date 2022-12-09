//
//  RegistrationView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI

struct RegistrationView: View {

    @State var name = ""
    @State var surname = ""
    @State var email = ""
    @State var age = ""
    @State var password = ""
    @State var checkPassword = ""


    var body: some View {
        ZStack {
            WallpaperView()
            VStack {
                Text("Registration")
                    .font(.largeTitle)
                    .foregroundColor(Color("neonBlue"))
                VStack(spacing: 10) {
                    DefaultTextFieldView(title: "Name", text: $name)
                    DefaultTextFieldView(title: "Surname", text: $surname)
                    DefaultTextFieldView(title: "Email", text: $email)
                    DefaultTextFieldView(title: "Age", text: $age)
                    DefaultTextFieldView(title: "Password", text: $password)
                    DefaultTextFieldView(title: "Repeat Password", text: $checkPassword)
                }
                .padding()
                Spacer()
                Spacer()
                OrangeButtonView(action: userRegistration(), title: "Sign Up")
                Spacer(minLength: 50)
            }
        }
    }

    func userRegistration() {

    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
