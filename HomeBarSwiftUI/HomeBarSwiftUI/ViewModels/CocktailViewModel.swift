//
//  CocktailViewModel.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 14.12.2022.
//

import Foundation

class CocktailsViewModel: ObservableObject {

    @Published var cocktail: [CocktailDB]
    
    init(cocktail: [CocktailDB]) {
        self.cocktail = cocktail
    }
    
    func getCocktail() {
        DataBaseService.shared.getCocktails { [unowned self] result in
            switch result {
            case .success(let cocktails):
            cocktail = cocktails
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
