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
                        isGender: $alcoTestViewModel.alcoTest.chooseGenderFrom,
                        titles: ["Man", "Woman"],
                        colors: [Color("neonBlue"), Color("neonOrange")],
                        font: Font.title3
                    )
                    .padding(EdgeInsets(
                        top: 0,
                        leading: 0,
                        bottom: 40,
                        trailing: 0
                    ))
                    HStack {
                        LabelView(text: "Your weight:")
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
                    .padding(.bottom, 16)
                    HStack {
                        LabelView(text: "You ate:")
                        Spacer()
                        CustomSwitch(
                            isEat: $alcoTestViewModel.alcoTest.hungrySwitch
                        )
                    }
                    .padding(.bottom, 16)
                    HStack {
                        LabelView(text: "Choose a drink:")
                        Spacer()
                        ButtonDrinkNameView(
                            action: { isPresented.toggle() },
                            text: alcoTestViewModel.alcoTest.nameAlcohol
                        )
                        .background(Color("neonOrange")).opacity(0.8)
                        .cornerRadius(8)
                    }
                    .padding(.bottom, 16)
                    SliderAlcoholTestView(
                        value: $alcoTestViewModel.alcoTest.sliderValue,
                        maxValue:
                            alcoTestViewModel.alcoTest.nameAlcohol == "Beer"
                        ? 5000
                        : 2000,
                        sizeWidth: 71,
                        sizeHeight: 40
                    )
                    .focused($isInputActive)
                    .padding(.bottom, 30)
                    HStack {
                        if !alcoTestViewModel.alcoTest.showAlert {
                            NavigationLink(
                                destination: ResultAlcoTestView(
                                    alcoTestViewModel: alcoTestViewModel
                                ),
                                label: {
                                    CalculateLabel(text: "Calculate")
                                })
                        } else {
                            CalculateLabel(text: "Calculate")
                        }
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        isInputActive = false
                        alcoTestViewModel.calculateTestResults()
                    })
                    .alert(isPresented: $alcoTestViewModel.alcoTest.showAlert) {
                        Alert(
                            title: Text("Not all fields are filled!"),
                            message: Text("Please complete all fields and try again.🍹"),
                            dismissButton: .default(Text("Ok"))
                        )
                    }
                }

                .padding()
                .background(Color(.gray).opacity(0.2))
                .cornerRadius(16)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                    colors: [Color("neonOrange"), Color("neonBlue")],
                    startPoint: .top,
                    endPoint: .bottom
                ).opacity(0.5), lineWidth: 2))
                .padding(EdgeInsets(top: 7, leading: 6, bottom: 7, trailing: 6))
                Spacer()
                Text("*Understand that the test only shows an estimate and cannot be proof. To accurately determine the level of alcohol in the blood, contact a specialist.")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .padding()
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
        Button(action: {isEat.toggle()}) {
            Text(isEat ? "Yes": "No")
                .foregroundColor(Color.white)
                .font(.title2)
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
    
    var body: some View {
        Button(action: action ) {
            Text(text)
                .frame(minWidth: 71, minHeight: 40)
                .font(.title2)
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


