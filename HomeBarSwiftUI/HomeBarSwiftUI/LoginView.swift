//
//  LoginView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 04.12.2022.
//

import SwiftUI

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""

    let homeBarLogoImage = "HomeBarLogo"
    let cocktailsLogoImage = "CocktailsLogo"

    let logInButton = "Log In"
    let registrationButton = "Registration"

    let neonOrange = "neonOrange"
    let neonBlue = "neonBlue"

    var body: some View {
        VStack() {
            Image(homeBarLogoImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            Text("User with \(email) not exist!")
                .foregroundColor(Color(neonOrange))
                .hidden()
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.black)
                .frame(width: 300.0)
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.black)
                .frame(width: 300.0)
            Spacer()
                .frame(height: 20)
            Button(logInButton) {
                print("hi")
            }
            .frame(width: 250, height: 40.0)
            .background(Color(neonOrange))
            .foregroundColor(Color.black)
            .cornerRadius(10)
            Button(registrationButton) {
                print("hi")
            }
            .frame(width: 150.0, height: 40.0)
            .foregroundColor(Color(neonBlue))
            Spacer()
            Image(cocktailsLogoImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct StartSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .background(Color.black)
    }
}
