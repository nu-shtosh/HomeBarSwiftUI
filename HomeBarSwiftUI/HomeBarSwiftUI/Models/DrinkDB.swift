//
//  DrinkDB.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 13.03.2023.
//

import Foundation

struct DrinkDataStore {
    static let shared = DrinkDataStore()

    let drinks = [
        "Vodka": 0.33,
        "Beer": 0.045,
        "Dry wine": 0.13,
        "Strong wine": 0.17,
        "Champagne": 0.13,
        "Jin": 0.41,
        "Whiskey": 0.42,
        "Rum": 0.334
    ]

    private init() { }
}
