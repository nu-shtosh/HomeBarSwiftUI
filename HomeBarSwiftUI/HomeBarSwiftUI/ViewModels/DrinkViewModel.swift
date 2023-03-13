//
//  DrinkModel.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 13.03.2023.
//

import Foundation

struct Drink {
    let name: String
    let alcohol: Double
}

extension Drink {
    static func getDrinks() -> [Drink] {
        
        let drinksNames = DrinkDataStore.shared.drinks
        var drinks: [Drink] = []
        
        for (drinkName, alcohol) in drinksNames {
            let drink = Drink(name: drinkName, alcohol: alcohol)
            drinks.append(drink)
        }
        return drinks
    }
}
