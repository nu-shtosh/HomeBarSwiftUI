//
//  FavoritesCocktailsView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 29.03.2023.
//

import SwiftUI

struct FavoritesCocktailsView: View {
    // MARK: - State Object Properties
    @StateObject var cocktailViewModel: CocktailsViewModel
    @StateObject var profileViewModel: ProfileViewModel

    // MARK: - Private Properties
    private let layout = [GridItem(.adaptive(minimum: screen.width / 2.2))]

    // MARK: - Body
    var body: some View {
        ZStack {
            // MARK: - Wallpaper View
            WallpaperView()
            ScrollView(.vertical, showsIndicators: false) {
                if profileViewModel.profile.favoritesCocktails.count > 0 {
                    // MARK: - Cocktails
                    Section {
                        LazyVGrid(columns: layout, spacing: 5) {
                            ForEach(cocktailViewModel.allCocktails, id: \.name) { item in
                                NavigationLink {
                                    CocktailDetailView(cocktail: item, profileViewModel: profileViewModel)
                                        .navigationTitle(item.name)
                                } label: {
                                    CocktailCellView(cocktail: item, image: cocktailViewModel.image)
                                }
                            }
                        } // End LazyVGrid
                    } // End Section
                    .foregroundColor(Color("neonBlue"))
                } else {
                    Text("You haven't added any cocktails in favorites yet.")
                        .foregroundColor(Color("neonOrange"))
                }
            } // End ScrollView
            .navigationTitle("Favorites Cocktails")
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.visible, for: .tabBar)
        } // End ZStack
        .onAppear{
            cocktailViewModel.getFavoritesCocktails(profileViewModel.profile.favoritesCocktails)
        }
    } // End Body
}
