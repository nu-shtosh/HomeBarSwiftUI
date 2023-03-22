//
//  AllIngredientsView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 22.03.2023.
//

import SwiftUI

struct AllIngredientsView: View {

    @StateObject var ingredientsViewModel: IngredientsViewModel

    var body: some View {
        ZStack() {
            WallpaperView()
            VStack {
                List {
                    ForEach(ingredientsViewModel.allIngredients, id: \.name) { ingredient in
                        Text(ingredient.name)
                    }
                }
            }
            .onAppear{
                ingredientsViewModel.getIngredients()
            }
        }
        .navigationTitle("Ingredients")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct AllIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        AllIngredientsView()
    }
}
