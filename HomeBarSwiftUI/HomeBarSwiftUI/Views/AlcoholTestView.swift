//
//  AlcotestView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 11.12.2022.
//

import SwiftUI

struct AlcoholTestView: View {
    @State private var text = ""
    @State private var isEat = false
    @FocusState private var isInputActive: Bool
    var body: some View {
        ZStack {
            WallpaperView()
            VStack {
                CustomSegmentedPickerView()
                    .padding(.bottom, 60)
                HStack {
                    Text("Your weight:")
                        .foregroundColor(Color("neonOrange"))
                        .font(.title)
                        .padding(.leading, 50)
                    Spacer()
                    DefaultTextFieldView(
                        title: "Kg",
                        text: $text,
                        sizeWidth: 100,
                        sizeHeight: 70
                    )
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                isInputActive = false
                            }
                        }
                    }
                    
                       
                }
                .padding(.bottom, 60)
                HStack {
                    Text("Your eat:")
                        .foregroundColor(Color("neonOrange"))
                        .font(.title)
                        .padding(.leading, 50)
                    Spacer()
                    Toggle(isEat ? "Yes" : "No", isOn: $isEat)
                        .toggleStyle(.button)
                        .tint(isEat ? Color("neonOrange") : Color("neonBlue"))
                        .font(.title)
                        .background(isEat ? Color("neonBlue").opacity(0.7) : Color("neonOrange").opacity(0.7))
                        .cornerRadius(12)
                }
                .padding(.bottom, 60)
                OrangeButtonView(action: {}, title: "Next")
                Spacer()
                Spacer()
                Spacer()
               
            }
            .padding()
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
