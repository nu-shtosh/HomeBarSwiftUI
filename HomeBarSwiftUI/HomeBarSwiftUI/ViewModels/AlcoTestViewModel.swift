//
//  AlcoTestViewModel.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 13.03.2023.
//

import Foundation

class AlcoTestViewModel: ObservableObject {
    @Published var alcoTest = AlcoTestManager.shared.getResultAlcoTest()
    private var widmarkDistribution = 0.7

    func loadData() {
        alcoTest.resultFormatted = "\(round(alcoTest.result * 100)/100)"
        showMotivating()
    }
    
    func showMotivating() {
        switch alcoTest.result {
        case 0...0.5:
            alcoTest.motivatingText = "Looks like the party has just begun. You can still get behind the wheel, but we recommend that you leave the car keys and have fun."
            alcoTest.resultImage = "5"
        case 0.5...1.5:
            alcoTest.motivatingText = "You are slightly drunk. Perhaps we should stop and forget the bitter coffee."
            alcoTest.resultImage = "1"
        case 1.5...2.5:
            alcoTest.motivatingText = "You have an average degree of intoxication. You should stop. Drink more water."
            alcoTest.resultImage = "6"
        case 2.5...3.5:
            alcoTest.motivatingText = "You are already quite drunk. Call a taxi and go to bed, for this advice tomorrow you will say \"Thank you\"!"
            alcoTest.resultImage = "4"
        case 3.5...5:
            alcoTest.motivatingText = "You are very drunk. We hope you can still read. Ask for help getting home."
            alcoTest.resultImage = "8"
        default:
            alcoTest.motivatingText = "We hope you are alive. If you survived and can read this, you may be in the Guinness Book of Records, but it's better to find another, safer way to do it."
            alcoTest.resultImage = "3"
        }
    }
    
    func calculateTestResults() {
        changeValue()
        let distributionUser = (Double(alcoTest.weightValue) ?? 0.0) * widmarkDistribution
        let multipleAlcohol = alcoTest.sliderValue * alcoTest.alcoholValue
        if distributionUser > 0 && multipleAlcohol > 0 {
            alcoTest.result = multipleAlcohol / distributionUser
            alcoTest.isPresented.toggle()
        } else {
            alcoTest.showAlert.toggle()
            return
        }
    }
    
    private func changeValue() {
        widmarkDistribution = alcoTest.chooseGenderFrom ? 0.6 : 0.7
        widmarkDistribution = alcoTest.hungrySwitch
        ? widmarkDistribution + 0.1
        : widmarkDistribution - 0.1
    }
}
