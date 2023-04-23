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
    @StateObject var profileViewModel: ProfileViewModel
    @StateObject var newCocktailViewModel: NewCocktailsViewModel

    // MARK: - State Properties
    @State var isHidden = false
    @State private var flag = true
    
    var ingredients: [String] = []

    // MARK: - Private Properties
    private let layout = [GridItem(.adaptive(minimum: screen.width / 2.2))]

    // MARK: - Body
    var body: some View {
        ZStack {
            // MARK: - Wallpaper View
            WallpaperView()
            ScrollView(.vertical, showsIndicators: false) {

                if cocktailViewModel.allCocktails.count > 0 {
                    // MARK: - All Cocktails
                    Section {
                        LazyVGrid(columns: layout, spacing: 5) {
                            ForEach(Array(cocktailViewModel.allCocktails), id: \.name) { item in
                                NavigationLink {
                                    CocktailDetailView(
                                        cocktail: item,
                                        profile: profileViewModel.profile,
                                        flag: $flag,
                                        profileViewModel: profileViewModel,
                                        newCocktailViewModel: newCocktailViewModel
                                    )
                                        .navigationTitle(item.name)
                                } label: {
                                    withAnimation {
                                        CocktailCellView(cocktail: item, flag: $flag)
                                    }
                                }
                            }
                        } // End LazyVGrid
                    } // End Section
                    .foregroundColor(Color("neonBlue"))
                } else {
                    Text("We can't find cocktails with selected ingredients")
                        .foregroundColor(Color("neonOrange"))
                }
            } // End ScrollView
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.visible, for: .tabBar)
        } // End ZStack
        .onAppear{
            if cocktailViewModel.allCocktails.count > 0 {
                cocktailViewModel.getCocktailWithIngredients(ingredients)
            }
        }
    } // End Body
}
