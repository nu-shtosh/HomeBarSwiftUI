//
//  AlcoTest.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 16.03.2023.
//

import Foundation

struct AlcoTest {
    
    var hungrySwitch: Bool
    var chooseGenderFrom: Bool
    var sliderValue: Double
    var showAlert: Bool
    var result: Double
    var weightValue: String
    var showResult: Bool
    var alcoholValue: Double
    var resultOfTextTwo: String
    var nameAlcohol: String
    var resultOfText: String
    var motivatingText: String
    var resultImage: String
    var promile: String
    var resultFormatted: String
    var warningText: String
}


// вспомогательный класс, чтобы в не городить при инициализации
class AlcoTestManager {
    static var shared = AlcoTestManager()
    
    func getResultAlcoTest() -> AlcoTest {
        let alcoTest = AlcoTest(
            hungrySwitch: false,
            chooseGenderFrom: false,
            sliderValue: 0,
            showAlert: false,
            result: 0,
            weightValue: "",
            showResult: false,
            alcoholValue: 0,
            resultOfTextTwo: "approximately",
            nameAlcohol: "Drink",
            resultOfText: "The blood alcohol level is",
            motivatingText: "The blood alcohol level is",
            resultImage: "",
            promile: "ppm.",
            resultFormatted: "",
            warningText: "Excessive alcohol consumption is harmful to your health!"
        )
        return alcoTest
    }
    private init() {}
}
