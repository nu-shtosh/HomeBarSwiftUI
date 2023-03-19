//
//  SliderAlcoholTestView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 12.03.2023.
//

import SwiftUI

struct SliderAlcoholTestView: View {
    @Binding var value: Double
    @State private var text = ""
    let maxValue: Int
    let sizeWidth: CGFloat?
    let sizeHeight: CGFloat?
    
    var body: some View {
        VStack {
            HStack {
                Text("Consumed alcohol")
                    .foregroundColor(Color("neonOrange"))
                    .font(.title3)
                Spacer()
                Text(value.formatted())
                    .foregroundColor(Color("neonBlue"))
                    .font(.title3)
                Text("ml")
                    .foregroundColor(Color("neonOrange"))
                    .font(.title3)
            }
            HStack {
                Slider(value: $value, in: 0...Double(maxValue), step: 1) {
                    Text("Measure")
                } minimumValueLabel: {
                    Image("20")
                } maximumValueLabel: {
                    Image("30")
                }
                .onChange(of: value) { newValue in
                    text = String(format:"%.f", newValue)
                }
                .animation(.easeInOut, value: value)
                .tint(Color("neonOrange"))
                TextField("ml", text: $text)
                    .onChange(of: text, perform: { newValue in
                        if newValue.count > 4  {
                            text = String(newValue.prefix(4))
                            value = Double(text) ?? 0.0
                        } else if Int(newValue) ?? 0 > maxValue {
                            text = String(maxValue)
                            value = Double(text) ?? 0.0
                        } else {
                            value = Double(text) ?? 0.0
                        }
                    })
                    .textFieldStyle(GradientTextFieldBackground())
                    .frame(width: sizeWidth, height: sizeHeight)
                    .keyboardType(.numberPad)
                    .foregroundColor(.black)
            }
        }
    }
}

struct SliderAlcoholTestView_Previews: PreviewProvider {
    static var previews: some View {
        SliderAlcoholTestView(value: .constant(1000), maxValue: 3000, sizeWidth: 71, sizeHeight: 40)
    }
}
