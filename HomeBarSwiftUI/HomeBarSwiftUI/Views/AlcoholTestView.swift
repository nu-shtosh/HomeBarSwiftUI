//
//  AlcotestView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 11.12.2022.
//

import SwiftUI

struct AlcoholTestView: View {
    @StateObject var alcoTestViewModel: AlcoTestViewModel
    @FocusState private var isInputActive: Bool
    @State private var isPresented = false
    @State private var isPresentedResult = false
    
    var body: some View {
        ZStack {
            WallpaperView()
            VStack {
                VStack {
                    CustomSegmentedPickerView(
                        isGender: $alcoTestViewModel.chooseGenderFrom,
                        titles: ["Man", "Woman"],
                        colors: [Color("neonBlue"), Color("neonOrange")],
                        font: Font.title3
                    )
                    .padding(EdgeInsets(
                        top: 10,
                        leading: 0,
                        bottom: 40,
                        trailing: 0
                    ))
                    HStack {
                        LabelView(text: "Your weight:")
                        Spacer()
                        NumberTextFieldView(
                            text: $alcoTestViewModel.weightValue,
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
                        CustomSwitch(isEat: $alcoTestViewModel.hungrySwitch)
                    }
                    .padding(.bottom, 16)
                    HStack {
                        LabelView(text: "Choose a drink:")
                        Spacer()
                        Button(action: { isPresented.toggle() }) {
                            Text(alcoTestViewModel.nameAlcohol)
                                .padding(EdgeInsets(
                                    top: 8,
                                    leading: 10,
                                    bottom: 8,
                                    trailing: 10
                                ))
                                .font(.title2)
                                .foregroundColor(Color("neonBlue"))
                        }
                        .background(Color("neonOrange")).opacity(0.8)
                        .cornerRadius(8)
                    }
                    .padding(.bottom, 16)
                    SliderAlcoholTestView(
                        value: $alcoTestViewModel.sliderValue,
                        maxValue: 3000,
                        sizeWidth: 71,
                        sizeHeight: 40
                    )
                    .focused($isInputActive)
                    .padding(.bottom, 30)
                    HStack {
                        if !alcoTestViewModel.showAlert {
                            NavigationLink(
                                destination: ResultAlcoTestView(alcoTestViewModel: alcoTestViewModel),
                                label: {
                                    CalculateLabel(text: "Calculate")
                                })
                        } else {
                            CalculateLabel(text: "Calculate")
                        }
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        alcoTestViewModel.calculateTestResults()
                    })
                    .alert(isPresented: $alcoTestViewModel.showAlert) {
                        Alert(
                            title: Text("ascsa"),
                            message: Text("ascsa"),
                            dismissButton: .default(Text("Ok"))
                        )
                    }
                }
                .padding()
                .background(Color(.gray).opacity(0.2))
                .cornerRadius(20)
                Spacer()
                Text("*Understand that the test only shows an estimate and cannot be proof. To accurately determine the level of alcohol in the blood, contact a specialist.")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .padding(5)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isInputActive = false
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            DrinksView(alcoTestViewModel: alcoTestViewModel)   
        }
        .onTapGesture {
            isInputActive = false
        }
    }
}

struct AlcoholTestView_Previews: PreviewProvider {
    static var previews: some View {
        AlcoholTestView(alcoTestViewModel: AlcoTestViewModel())
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

struct CalculateLabel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 22))
            .frame(width: 300, height: 50)
            .background(Color("neonOrange"))
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

struct CustomSwitch: View {
    @Binding var isEat: Bool
    
    var body: some View {
        Toggle(isEat ? " Yes  " : " No   ", isOn: $isEat)
            .toggleStyle(.button)
            .tint(isEat ? Color("neonOrange") : Color("neonBlue"))
            .font(.title2)
            .background(isEat ? Color("neonBlue").opacity(0.8) : Color("neonOrange").opacity(0.7))
            .cornerRadius(8)
    }
}
