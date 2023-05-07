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
    @State private var maxValue = 2000
    var body: some View {
        ZStack {
            WallpaperView()
            VStack {
                VStack {
                    // MARK: - Sex Picker
                    CustomSegmentedPickerView(
                        isGender: $alcoTestViewModel.alcoTest.chooseGenderFrom,
                        titles: ["Man", "Woman"],
                        colors: [Color("neonBlue"), Color("neonOrange")],
                        font: Font.title3
                    )
                    .padding(EdgeInsets(
                        top: 10,
                        leading: 0,
                        bottom: 20,
                        trailing: 0
                    ))
                    
                    // MARK: - Weight
                    HStack {
                        LabelView(text: "Your weight")
                        Spacer()
                        NumberTextFieldView(
                            text: $alcoTestViewModel.alcoTest.weightValue,
                            label: "kg",
                            sizeWidth: 71,
                            sizeHeight: 40,
                            maxValue: 250
                        )
                        .focused($isInputActive)
                    }
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                        colors: [Color("neonBlue"), Color("neonOrange")],
                        startPoint: .top,
                        endPoint: .bottom
                    ).opacity(0.3), lineWidth: 2))
                    .background(LinearGradient(colors: [Color("neonBlue"), Color("neonOrange")],
                                               startPoint: .top,
                                               endPoint: .bottom).opacity(0.15))
                    
                    // MARK: - Eaten
                    HStack {
                        LabelView(text: "Have you eaten?")
                        Spacer()
                        CustomSwitch(
                            isEat: $alcoTestViewModel.alcoTest.hungrySwitch
                        )
                    }
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                        colors: [Color("neonBlue"), Color("neonOrange")],
                        startPoint: .top,
                        endPoint: .bottom
                    ).opacity(0.3), lineWidth: 2))
                    .background(LinearGradient(colors: [Color("neonBlue"), Color("neonOrange")],
                                               startPoint: .top,
                                               endPoint: .bottom).opacity(0.15))
                    
                    // MARK: - Drink
                    HStack {
                        LabelView(text: "What have you drunk?")
                            .scaledToFill()
                            .minimumScaleFactor(0.5)
                        Spacer()
                        ButtonDrinkNameView(
                            action: { isPresented.toggle() },
                            text: alcoTestViewModel.alcoTest.nameAlcohol,
                            value: $alcoTestViewModel.alcoTest.sliderValue,
                            maxValue: $maxValue
                        )
                        .background(Color("neonOrange")).opacity(0.8)
                        .cornerRadius(8)
                    }
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                        colors: [Color("neonBlue"), Color("neonOrange")],
                        startPoint: .top,
                        endPoint: .bottom
                    ).opacity(0.3), lineWidth: 2))
                    .background(LinearGradient(colors: [Color("neonBlue"), Color("neonOrange")],
                                               startPoint: .top,
                                               endPoint: .bottom).opacity(0.15))
                    
                    // MARK: - Consumed Alcohol
                    SliderAlcoholTestView(
                        value: $alcoTestViewModel.alcoTest.sliderValue,
                        maxValue: maxValue,
                        sizeWidth: 71,
                        sizeHeight: 40
                    )
                    .focused($isInputActive)
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                        colors: [Color("neonBlue"), Color("neonOrange")],
                        startPoint: .top,
                        endPoint: .bottom
                    ).opacity(0.3), lineWidth: 2))
                    .background(LinearGradient(colors: [Color("neonBlue"), Color("neonOrange")],
                                               startPoint: .top,
                                               endPoint: .bottom).opacity(0.15))
                    .padding(.bottom)
                    
                    // MARK: - Calculate Button
                    HStack {
                        Button {
                            isInputActive = false
                            alcoTestViewModel.calculateTestResults()
                        } label: {
                            CalculateLabel(text: "Calculate")
                        }
                        .navigationDestination(isPresented: $alcoTestViewModel.alcoTest.isPresented) {
                            ResultAlcoTestView(
                                alcoTestViewModel: alcoTestViewModel
                            )
                        }
                    }
                    .padding(.top, 20)
                    .alert(isPresented: $alcoTestViewModel.alcoTest.showAlert) {
                        Alert(
                            title: Text("Not all fields are filled!"),
                            message: Text("Please complete all fields and try again.🍹"),
                            dismissButton: .default(Text("Ok"))
                        )
                    }
                }
                Spacer()
                
                // MARK: - Warning Text
                Text("*Please note, that this test shows only an estimated result and can't be a proof of your actual condition. For more accurate results of the alcohol level in your blood, please contact a specialist.")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
//                    .padding()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.large)

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
                .background(
                    BackgroundClearView()
                )
        }
        .onTapGesture {
            isInputActive = false
        }
    }
}

struct AlcoholTestView_Previews: PreviewProvider {
    static var previews: some View {
        AlcoholTestView(
            alcoTestViewModel: AlcoTestViewModel())
    }
}

struct LabelView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(Color("neonOrange"))
            .font(.title3)
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
        Button(action: {isEat.toggle()}) {
            Text(isEat ? "Yes": "No")
                .foregroundColor(Color.white)
                .font(.title3)
                .frame(width: 71, height: 40)
                .background(isEat
                            ? Color("neonBlue").opacity(0.8)
                            : Color("neonOrange").opacity(0.8)
                )
                .cornerRadius(8)
        }
    }
}

struct ButtonDrinkNameView: View {
    var action: () -> ()
    var text: String
    @Binding var value: Double
    @Binding var maxValue: Int
    
    var body: some View {
        Button(action: action ) {
            Text(text)
                .frame(minWidth: 71, minHeight: 40)
                .font(.title3)
                .scaledToFill()
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.white)
                .padding(EdgeInsets(
                    top: 0,
                    leading:
                        withAnimation {
                            text.count > 5 ? 5 : 0
                        },
                    bottom: 0,
                    trailing:
                        withAnimation {
                            text.count > 5 ? 5 : 0
                        }))
        }
        .onChange(of: text) { newValue in
            if newValue == "Beer" {
                maxValue = 5000
            } else if value > 2000 && newValue != "Beer" {
                maxValue = 2000
                value = Double(maxValue)
            } else if newValue != "Beer" {
                maxValue = 2000
            }
        }
    }
}

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}


