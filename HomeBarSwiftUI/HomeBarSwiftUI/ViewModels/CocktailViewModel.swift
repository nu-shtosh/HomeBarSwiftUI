//
//  CocktailViewModel.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 14.12.2022.
//

import Foundation
import UIKit

class CocktailsViewModel: ObservableObject {

    @Published var allCocktails: [CocktailDB]
    @Published var cocktail: CocktailDB
    @Published var image: Data

    init(allCocktails: [CocktailDB],cocktail: CocktailDB, image: Data) {
        self.allCocktails = allCocktails
        self.cocktail = cocktail
        self.image = image
    }
    
    func configureCocktail(_ name: String, _ receptText: String, _ ingredientsTextfield: inout [String], _ ingredientsText: inout [String], _ measureTextfield: [String], _ measureText: [String], _ nameButtonTextfield: [String], _ nameButtonText: [String]) -> CocktailDB {
        
        var measureIngredientTextfield = measureTextfield.enumerated().map { (index, value) in
            value + " " + nameButtonTextfield[index]
        }
        var measureIngredientText = measureText.enumerated().map { (index, value) in
            value + " " + nameButtonText[index]
        }
        measureIngredientTextfield.remove(at: 0)
        measureIngredientText.remove(at: 0)
        if ingredientsTextfield.count > 0 {
            ingredientsTextfield.remove(at: 0)
        }
        if ingredientsText.count > 0 {
            ingredientsText.remove(at: 0)
        }
        cocktail.ingredientsMeasures = measureIngredientTextfield + measureIngredientText
        cocktail.ingredientsNames = ingredientsTextfield + ingredientsText
        cocktail.name = name
        cocktail.instructions = receptText
        cocktail.image = " "
        cocktail.alcoholic = " "
        cocktail.tags = " "
        cocktail.comments = [" ": " "]
        return cocktail
    }

    func getCocktail() {
        DataBaseService.shared.getCocktails { [unowned self] result in
            switch result {
            case .success(let cocktails):
                allCocktails = cocktails
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getCocktailWithIngredients(_ list: [String]) {
        DataBaseService.shared.getCocktailsWithSelectedIngredients(list) { [unowned self] result in
            switch result {
            case .success(let cocktails):
                allCocktails = cocktails
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getFavoritesCocktails(_ list: [String]) {
        DataBaseService.shared.getFavoritesCocktails(list) { [unowned self] result in
            switch result {
            case .success(let cocktails):
                allCocktails = cocktails
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getImage(imageURL: String) {
        NetworkManager.shared.fetchImage(from: imageURL) { [unowned self] result in
            switch result {
            case .success(let images):
                image = images
            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }
}
