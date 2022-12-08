//
//  usernameTextfieldView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI

struct LogInTextFieldView: View {

    @State var email = ""
    @State var password = ""

    var body: some View {
        VStack(spacing: 10) {
            // MARK: - Name TextField
            TextField("Email", text: $email)
                .textFieldStyle(
                    GradientTextFieldBackground(
                        systemImageString: "person"
                    )
                )
                .background(Color.white.opacity(0.8))
                .cornerRadius(5)
            // MARK: password TextField
            SecureField("Password", text: $password)
                .textFieldStyle(
                    GradientTextFieldBackground(
                        systemImageString: "key"
                    )
                )

                .background(Color.white.opacity(0.8))
                .cornerRadius(5)
        }
        .padding()
    }
}

struct LogInTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        LogInTextFieldView(email: "", password: "")
    }
}

struct GradientTextFieldBackground: TextFieldStyle {

    let systemImageString: String

    // Hidden function to conform to this protocol
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(
                    LinearGradient(
                        colors: [
                            Color("neonOrange"),
                            Color("neonBlue")
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 40)

            HStack {
                Image(systemName: systemImageString)
                // Reference the TextField here
                configuration
            }
            .padding(.leading)
            .foregroundColor(.black)
        }
    }
}
