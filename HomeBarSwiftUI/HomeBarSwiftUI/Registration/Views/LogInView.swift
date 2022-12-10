//
//  LogInView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore

struct LogInView: View {

    @State var email = ""
    @State var password = ""

    @State var message = ""
    @State var alert = false
    @State var show = false

    var body: some View {
        NavigationView{
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
                    OrangeButtonView(action: logInDidTapped, title: "Log In")
                        .alert(isPresented: $alert) {
                            Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("OK")))
                        }
                    HStack(spacing: 8) {
                        Text("Don't Have An Account?")
                            .foregroundColor(Color("neonOrange").opacity(0.6))
                        NavigationLink(destination: RegistrationView()) {
                            Text("Sign Up")
                                .font(.system(size: 22))
                                .foregroundColor(Color("neonBlue"))
                        }.navigationTitle(Text("Log In").foregroundColor(Color("neonBlue")))
                    }
                    Spacer(minLength: 150)
                }
            }
        }
    }

    func logInDidTapped() {
        logInWithEmail(email: self.email, password: self.password) { (verified, status) in
            if !verified {
                self.message = status
                self.alert.toggle()
            } else {
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
            }
        }
    }

    func signUpDidTapped() {
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



struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
