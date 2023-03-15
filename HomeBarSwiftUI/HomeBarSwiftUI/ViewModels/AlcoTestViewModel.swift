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
            motivatingText = "Похоже, что вечеринка только началась. Вы еще можете сесть за руль, но мы Вам рекомендуем  оставить ключи от машины и развлекаться."
            resultImage = "11"
        case 0.5...1.5:
            motivatingText = "У Вас легкое опьянение. Возможно, стоит остановиться и выпить крепкого кофе."
            resultImage = "15"
        case 1.5...2.5:
            motivatingText = "У Вас средняя степень опьянения."
            resultImage = "12"
        case 2.5...3:
            motivatingText = "Вы уже изрядно пьяны. Вызывайте такси и ложитесь спать, за этот совет завтра Вы скажите \"Спасибо\"!"
            resultImage = "14"
        case 3...5:
            motivatingText = "Вы очень сильно пьяны. Надеемся, Вы еще можете читать. Попросите помощи, чтобы добраться до дома."
            resultImage = "18"
        default:
            motivatingText = "Надеемся, что Вы живы."
            resultImage = "13"
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
