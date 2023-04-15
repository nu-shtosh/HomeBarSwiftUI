//
//  Extansion + TextField.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI

struct GradientTextFieldBackgroundWithImage: TextFieldStyle {
    let systemImageString: String
    @Binding var text: String

    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
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
                .cornerRadius(10)
                .frame(height: 40)

            HStack {
                Image(systemName: systemImageString)
                // Reference the TextField here
                configuration
            }
            .modifier(ClearButton(text: $text))
            .padding(.trailing, 10)
            .padding(.leading, 10)
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
                .frame(minHeight: 40, maxHeight: 1000)
                configuration
                .padding(.leading)
        }

    }
}

public struct ClearButton: ViewModifier {
    @Binding var text: String

    public init(text: Binding<String>) {
        self._text = text
    }

    public func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.secondary)
                .opacity(text == "" ? 0 : 1)
                .onTapGesture { self.text = "" } // onTapGesture or plainStyle button
        }
    }
}
