//
//  AlcotestView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 11.12.2022.
//

import SwiftUI

struct AlcoholTestView: View {
    @State private var textWeight = "80"
    @State private var isEat = false
    @State var value = 100.0
    @State var valueWeight = 80.0
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        ZStack {
            WallpaperView()
            VStack {
                CustomSegmentedPickerView(
                    titles: ["Man", "Woman"],
                    colors: [Color("neonBlue"), Color("neonOrange")],
                    font: Font.title3
                )
                .padding(.bottom, 40)
                HStack {
                    LabelView(text: "Your weight:")
                    Spacer()
                    NumberTextFieldView(
                        text: $textWeight,
                        value: $valueWeight,
                        label: "kg",
                        sizeWidth: 71,
                        sizeHeight: 40,
                        maxValue: 250
                    )
                    .focused($isInputActive)
                }
                .padding(.bottom, 16)
                HStack {
                    LabelView(text: "You ate:")
                    Spacer()
                    CustomSwitch(isEat: $isEat)
                }
                .padding(.bottom, 16)
                HStack {
                    LabelView(text: "Choose a drink:")
                    Spacer()
                    Button(action: {}) {
                        Text("Drink")
                            .font(.title2)
                            .foregroundColor(Color("neonBlue"))
                    }
                    .frame(width: 71, height: 40)
                    .background(Color("neonOrange")).opacity(0.7)
                    
                    .cornerRadius(8)
              
                    
                }
                .padding(.bottom, 16)
                SliderAlcoholTestView(value: $value)
                    .padding(.bottom, 30)
                OrangeButtonView(action: {}, title: "Next")
                Spacer()
            }
            .padding()
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isInputActive = false
                }
            }
        }
        .onTapGesture {
            isInputActive = false
        }
    }
}


struct AlcoholTestView_Previews: PreviewProvider {
    static var previews: some View {
        AlcoholTestView()
    }
}


struct LabelView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(Color("neonOrange"))
            .font(.title2)
    }
}

struct CustomSwitch: View {
    
    @Binding var isEat: Bool
    
    var body: some View {
        Toggle(isEat ? " Yes  " : " No   ", isOn: $isEat)
            .toggleStyle(.button)
            .tint(isEat ? Color("neonOrange") : Color("neonBlue"))
            .font(.title2)
            .background(isEat ? Color("neonBlue").opacity(0.7) : Color("neonOrange").opacity(0.7))
            .cornerRadius(8)
    }
}
