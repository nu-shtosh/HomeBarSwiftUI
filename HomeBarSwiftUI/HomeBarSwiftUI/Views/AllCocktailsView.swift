//
//  AllCocktailsView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 14.12.2022.
//

import SwiftUI

struct AllCocktailsView: View {

    // MARK: - State Object Properties
    @StateObject var cocktailViewModel: CocktailsViewModel
    @StateObject var profileViewModel: ProfileViewModel
    @StateObject var newCocktailViewModel: NewCocktailsViewModel
    
    // MARK: - State Properties
    @State var isHidden = false
    @State private var flag = true
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
            } // End ScrollView
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.visible, for: .tabBar)
        } // End ZStack
        .onAppear{
            cocktailViewModel.getCocktail()
        }
    } // End Body
}
