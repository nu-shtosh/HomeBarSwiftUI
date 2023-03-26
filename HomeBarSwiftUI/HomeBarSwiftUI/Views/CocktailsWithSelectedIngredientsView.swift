//
//  CocktailsWithSelectedIngredientsView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 25.03.2023.
//

import SwiftUI

struct CocktailsWithSelectedIngredientsView: View {
    // MARK: - State Object Properties
    @StateObject var cocktailViewModel: CocktailsViewModel

    // MARK: - State Properties
    @State var isHidden = false

    var ingredients: [String] = []

    // MARK: - Private Properties
    private let layout = [GridItem(.adaptive(minimum: screen.width / 2.2))]

    // MARK: - Body
    var body: some View {
        ZStack {
            // MARK: - Wallpaper View
            WallpaperView()
            ScrollView(.vertical, showsIndicators: false) {

                // MARK: - All Cocktails
                Section {
                    LazyVGrid(columns: layout, spacing: 5) {
                        ForEach(cocktailViewModel.allCocktails, id: \.name) { item in
                            NavigationLink {
                                CocktailDetailView(cocktail: item)
                                    .navigationTitle(item.name)
                            } label: {
                                withAnimation {
                                    CocktailCellView(cocktail: item)
                                }
                            }
                        }
                    } // End LazyVGrid
                } // End Section
                .foregroundColor(Color("neonBlue"))
            } // End ScrollView
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.visible, for: .tabBar)
        } // End ZStack
        .onAppear{
            cocktailViewModel.getCocktailWithIngredients(ingredients)
        }
    } // End Body
}
