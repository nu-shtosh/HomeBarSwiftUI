//
//  NewCocktailsView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 15.04.2023.
//
import SwiftUI

struct NewCocktailsView: View {

    // MARK: - State Object Properties
    @StateObject var newCocktailViewModel: NewCocktailsViewModel
    @StateObject var profileViewModel: ProfileViewModel

    // MARK: - State Properties
    @State var isHidden = false

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
                        ForEach(Array(newCocktailViewModel.allCocktails), id: \.name) { item in
                            NavigationLink {
                                CocktailDetailView(cocktail: item, profile: profileViewModel.profile, profileViewModel: profileViewModel)
                                    .navigationTitle(item.name)
                            } label: {
                                withAnimation {
                                    
                                    NewCocktailCell(cocktail: item, image: $newCocktailViewModel.image)
                                }
                            }
                            .onAppear {
                                newCocktailViewModel.getImageNewCocktail(item.name)
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
            newCocktailViewModel.getNewCocktail()
        }
    } // End Body
}

