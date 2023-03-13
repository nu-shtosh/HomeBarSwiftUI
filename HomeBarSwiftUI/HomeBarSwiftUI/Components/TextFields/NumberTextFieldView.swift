//
//  NumberTextFieldView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 12.03.2023.
//

import SwiftUI

struct NumberTextFieldView: View {
    @Binding var text: String
    var label: String
    let sizeWidth: CGFloat?
    let sizeHeight: CGFloat?
    let maxValue: Int
    
    var body: some View {
        TextField(label, text: $text)
            .onChange(of: text, perform: { newValue in
                if newValue.count > 3  {
                    text = String(newValue.prefix(3))
                } else if Int(newValue) ?? 0 > maxValue {
                    text = String(250)
                }
            })
            .textFieldStyle(GradientTextFieldBackground())
            .frame(width: sizeWidth, height: sizeHeight)
            .keyboardType(.numberPad)
            .foregroundColor(.black)
    }
}

struct NumberTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        NumberTextFieldView(
            text: .constant(""),
            label: "Kg",
            sizeWidth: nil,
            sizeHeight: nil,
            maxValue: 0
        )
    }
}

