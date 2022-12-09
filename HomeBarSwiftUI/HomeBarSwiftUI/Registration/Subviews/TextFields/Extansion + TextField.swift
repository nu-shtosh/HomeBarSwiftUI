//
//  Extansion + TextField.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI

struct GradientTextFieldBackgroundWithImage: TextFieldStyle {
    let systemImageString: String

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
                    ),
                    lineWidth: 3
                )
                .background(Color.white.opacity(0.8))
                .cornerRadius(5)
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


struct GradientTextFieldBackground: TextFieldStyle {
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
                    ),
                    lineWidth: 3
                )
                .background(Color.white.opacity(0.8))
                .cornerRadius(5)
                .frame(height: 40)
                configuration
                .padding(.leading)
        }

    }
}
