//
//  AlcoTestViewModel.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 13.03.2023.
//

import Foundation

class AlcoTestViewModel: ObservableObject {
    
    @Published var hungrySwitch = false
    @Published var chooseGenderFrom = false
    @Published var sliderValue = 0.0
    @Published var showAlert = false
    @Published var result = 0.0
    @Published var weightValue = "0"
    @Published var nameAlcohol = "Drink"
    
    private var widmarkDistribution = 0.7
    private var weightDrink = 0.0
    @Published var alcoholValue = 0.33
    
    func calculateTestResults() {
        changeValue()
        let distributionUser = (Double(weightValue) ?? 0.0) * widmarkDistribution
        print(weightValue)
        print(widmarkDistribution)
        print(distributionUser)
        let multipleAlcohol = weightDrink * alcoholValue
        
        if distributionUser > 0 && multipleAlcohol > 0 {
            result = multipleAlcohol / distributionUser
            print(result)
        } else {
            showAlert.toggle()
            print("errpor")
            return
        }
     }
    
    func changeValue() {
        weightDrink = sliderValue
        widmarkDistribution = chooseGenderFrom ? 0.6 : 0.7
        widmarkDistribution = hungrySwitch
        ? widmarkDistribution + 0.1
        : widmarkDistribution - 0.1
    }
}
