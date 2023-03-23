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
    @Published var image: Data
    
    init(cocktail: [CocktailDB], image: Data) {
        self.allCocktails = cocktail
        self.image = image
    }
    
    func getCocktail() {
        DataBaseService.shared.getCocktails { [unowned self] result in
            print(result)
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
