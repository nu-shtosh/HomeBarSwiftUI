//
//  RegistrationView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

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
                    Spacer(minLength: 200)
                    OrangeButtonView(action: userRegistration, title: "Sign Up")
                    BlueButtonView(action: {
                        UserDefaults.standard.set(false, forKey: "status")
                        NotificationCenter.default.post(
                            name: NSNotification.Name("statusChange"), object: nil)
                    }, title: "sca")
                    Spacer(minLength: 100)
                }
            }
    }

    func userRegistration() {
    }

    func returnOnLogIn() {
        UserDefaults.standard.set(false, forKey: "status")
        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
    }
}

func signUpWithEmail(email: String, password: String, completion: @escaping (Bool, String) -> Void ) {
    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
        if error != nil {
            completion(false, (error?.localizedDescription ?? "No error description!"))
            return
        }
        completion(true, (result?.user.email)!)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
