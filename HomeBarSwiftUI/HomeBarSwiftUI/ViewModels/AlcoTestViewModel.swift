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
    @Published var weightValue = ""
    @Published var showResult = false
    @Published var alcoholValue = 0.0
    
    @Published var nameAlcohol = "Drink"
    @Published var motivatingText = ""
    @Published var resultImage = ""
    @Published var promile = ""
    @Published var resultFormatted = ""
    
    private var widmarkDistribution = 0.7
    func loadData() {
        resultFormatted = "\(round(result * 100)/100)"
        promile = "ppm."
        showMotivating()
    }
    
    func showMotivating() {
        switch result {
        case 0...0.5:
            motivatingText = "Looks like the party has just begun. You can still get behind the wheel, but we recommend that you leave the car keys and have fun."
            resultImage = "5"
        case 0.5...1.5:
            motivatingText = "You are slightly drunk. Perhaps we should stop and forget the bitter coffee."
            resultImage = "1"
        case 1.5...2.5:
            motivatingText = "You have an average degree of intoxication. You should stop. Drink more water."
            resultImage = "6"
        case 2.5...3.5:
            motivatingText = "You are already quite drunk. Call a taxi and go to bed, for this advice tomorrow you will say \"Thank you\"!"
            resultImage = "4"
        case 3.5...5:
            motivatingText = "You are very drunk. We hope you can still read. Ask for help getting home."
            resultImage = "8"
        default:
            motivatingText = "We hope you are alive. If you survived and can read this, you may be in the Guinness Book of Records, but it's better to find another, safer way to do it."
            resultImage = "3"
        }
    }
    
    func calculateTestResults() {
        changeValue()
        let distributionUser = (Double(weightValue) ?? 0.0) * widmarkDistribution
        let multipleAlcohol = sliderValue * alcoholValue
        if distributionUser > 0 && multipleAlcohol > 0 {
            result = multipleAlcohol / distributionUser
        } else {
            showAlert.toggle()
            return
        }
    }
    
    private func changeValue() {
        widmarkDistribution = chooseGenderFrom ? 0.6 : 0.7
        widmarkDistribution = hungrySwitch
        ? widmarkDistribution + 0.1
        : widmarkDistribution - 0.1
    }
}
