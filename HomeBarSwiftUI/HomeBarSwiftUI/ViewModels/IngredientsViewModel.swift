//
//  IngredientsViewModel.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 22.03.2023.
//

import SwiftUI

class IngredientsViewModel: ObservableObject {

    @Published var allIngredients: [IngredientDB]

    init(allIngredients: [IngredientDB]) {
        self.allIngredients = allIngredients
    }

    func getIngredients() {
        DataBaseService.shared.getIngredients { [unowned self] result in
            switch result {
            case .success(let ingredients):
                allIngredients = ingredients
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
