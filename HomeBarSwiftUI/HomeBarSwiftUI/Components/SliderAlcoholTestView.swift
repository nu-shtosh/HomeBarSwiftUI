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
    
    var body: some View {
        VStack {
            Text("\(value.formatted()) ml.")
                .lineLimit(1)
                .foregroundColor(Color("neonOrange"))
                .padding(.bottom, -5)
            HStack {
                Slider(value: $value, in: 0...3000, step: 1) {
                    Text("Measure")
                } minimumValueLabel: {
                    Image("20")
                } maximumValueLabel: {
                    Image("30")
                }
                .animation(.easeInOut, value: value)
                .tint(Color("neonOrange"))
                .onChange(of: value) { newValue in
                    text = newValue.formatted()
                    print(value)
                }
                NumberTextFieldView(
                    text: $text,
                    value: $value,
                    label: "ml",
                    sizeWidth: 100,
                    sizeHeight: 50,
                    maxValue: 3000
                )
            }
        }
        .onAppear {
            text = value.formatted()
        }
    }
}

struct SliderAlcoholTestView_Previews: PreviewProvider {
    static var previews: some View {
        SliderAlcoholTestView(value: .constant(100))
    }
}
