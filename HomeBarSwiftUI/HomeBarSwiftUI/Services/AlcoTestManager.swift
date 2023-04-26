//
//  AlcoTestManager.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 18.03.2023.
//

import Foundation

class AlcoTestManager {
    static var shared = AlcoTestManager()
    
    func getResultAlcoTest() -> AlcoTest {
        let alcoTest = AlcoTest(
            hungrySwitch: false,
            chooseGenderFrom: false,
            sliderValue: 0,
            showAlert: false,
            isPresented: false,
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
