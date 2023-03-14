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
    @Published var nameAlcohol = "Drink"
    @Published var showResult = false
    
    private var widmarkDistribution = 0.7
    private var weightDrink = 0.0
    @Published var alcoholValue = 0.0
    
    @Published var resultText = ""
    @Published var motivatingText = ""
    @Published var resultImage = ""
    
    func loadData() {
        resultText = "Уровень алкоголя в крови составляет примерно \(round(result * 100)/100) промилле."
        showMotivating()
    }
    
    func showMotivating() {
        switch result {
        case 0...0.16:
            motivatingText = "Похоже, что вечеринка только началась. Оставьте ключи от машины и развлекайтесь."
            resultImage = "5.png"
        case 0.17...1.9:
            motivatingText = "У Вас легкое опьянение. Возможно, стоит остановиться и выпить крепкого кофе."
            resultImage = "6.png"
        case 2...2.7:
            motivatingText = "Вы уже изрядно пьяны. Вызывайте такси и ложитесь спать, за этот совет завтра Вы скажите \"Спасибо\"!"
            resultImage = "4.png"
        case 2.8...3.5:
            motivatingText = "Вы очень сильно пьяны. Надеемся, Вы еще можете читать. Попросите помощи, чтобы добраться до дома."
            resultImage = "8.png"
        default:
            motivatingText = "Надеемся, что Вы живы."
            resultImage = "3.png"
        }
    }
    
    func calculateTestResults() {
        changeValue()
        let distributionUser = (Double(weightValue) ?? 0.0) * widmarkDistribution
        let multipleAlcohol = weightDrink * alcoholValue
        if distributionUser > 0 && multipleAlcohol > 0 {
            result = multipleAlcohol / distributionUser
//            showResult.toggle()
        } else {
            showAlert.toggle()
            return
        }
    }
    
    private func changeValue() {
        weightDrink = sliderValue
        widmarkDistribution = chooseGenderFrom ? 0.6 : 0.7
        widmarkDistribution = hungrySwitch
        ? widmarkDistribution + 0.1
        : widmarkDistribution - 0.1
    }
}
