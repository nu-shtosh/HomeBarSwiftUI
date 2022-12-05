//
//  ContentView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 04.12.2022.
//

import SwiftUI
//import CoreData

struct ContentView: View {

    @State private var email = ""
    @State private var password = ""

    let homeBarLogoImage = "HomeBarLogo"
    let cocktailsLogoImage = "CocktailsLogo"

    let logInButton = "Log In"
    let registrationButton = "Registration"

    let neonOrange = "neonOrange"
    let neonBlue = "neonBlue"

    var body: some View {
        ScrollView{
            VStack() {
                Image(homeBarLogoImage)
                    .resizable()
                //                .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
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
                Spacer(minLength:35)
                Image(cocktailsLogoImage)
                    .resizable()
                    .frame(width: 250, height: 90)
            }
            .frame(width: 412) // пока захардкодил надо сравять фрейм стаквью с фрейм вью
        }
        .background(Color.black)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
