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
        "Водка": 0.33,
        "Пиво": 0.045,
        "Сухое вино": 0.13,
        "Крепленое вино": 0.17,
        "Шампанское": 0.13,
        "Джин": 0.41,
        "Виски": 0.42,
        "Ром": 0.334
    ]

    private init() { }
}
