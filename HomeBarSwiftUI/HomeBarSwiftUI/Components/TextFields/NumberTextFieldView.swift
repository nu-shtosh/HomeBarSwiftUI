//
//  NumberTextFieldView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 12.03.2023.
//

import SwiftUI

struct NumberTextFieldView: View {
    @State private var showAlert = false
    @Binding var text: String
    @Binding var value: Double
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
            .alert("Wrong Format", isPresented: $showAlert, actions: {}) {
                Text("Please enter value from 0 to \(maxValue)")
            }
    }
}

struct NumberTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        NumberTextFieldView(
            text: .constant(""),
            value: .constant(100.0),
            label: "Kg",
            sizeWidth: nil,
            sizeHeight: nil,
            maxValue: 0
        )
    }
}

