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

    var cocktailsCount: Int {
        profileViewModel.profile.favoritesCocktails.count
    }

    // MARK: - Body
    var body: some View {
        ZStack {

            // MARK: - Wallpaper View
            WallpaperView()
            ScrollView(.vertical, showsIndicators: false) {
                if cocktailsCount > 0 {
                    // MARK: - Cocktails

                    Section {
                        LazyVGrid(columns: layout, spacing: 5) {
                            ForEach(Array(cocktailViewModel.allCocktails), id: \.name) { item in
                                NavigationLink {
                                    CocktailDetailView(cocktail: item, profile: profileViewModel.profile, profileViewModel: profileViewModel)
                                        .navigationTitle(item.name)
                                } label: {
                                    VStack {
                                        CocktailCellView(cocktail: item, image: cocktailViewModel.image)
                                    }
                                }
                            }
                        } // End LazyVGrid
                    } // End Section
                    .foregroundColor(Color("neonBlue"))
                } else {
                    Text("You haven't added any cocktails in favorites yet.")
                        .foregroundColor(Color("neonOrange"))
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                            colors: [Color("neonBlue"), Color("neonOrange")],
                            startPoint: .top,
                            endPoint: .bottom
                        ).opacity(0.3), lineWidth: 2))
                        .background(LinearGradient(colors: [Color("neonBlue"),
                                                            Color("neonOrange")],
                                                   startPoint: .top,
                                                   endPoint: .bottom).opacity(0.15))
                        .cornerRadius(16)
                }
            } // End ScrollView
            .padding(.vertical)
            .navigationTitle("Favorites Cocktails")
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.visible, for: .tabBar)
        } // End ZStack
        .onAppear{
            if cocktailsCount > 0 {
                cocktailViewModel.getFavoritesCocktails(profileViewModel.profile.favoritesCocktails)
            }
        }
    } // End Body
}



struct TestScreen: View {

    var body: some View {
            Text("TEST")
                .font(.largeTitle)
                .bold()
    }
}
