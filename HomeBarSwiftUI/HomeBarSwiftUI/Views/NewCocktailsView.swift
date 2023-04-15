//
//  NewCocktailsView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 15.04.2023.
//
import SwiftUI

struct NewCocktailsView: View {

    // MARK: - State Object Properties
    @StateObject var сocktailViewModel: CocktailsViewModel
    @StateObject var profileViewModel: ProfileViewModel
    @State private var image = Data()

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
                        ForEach(Array(сocktailViewModel.allCocktails), id: \.name) { item in
                            NavigationLink {
                                CocktailDetailView(cocktail: item, profile: profileViewModel.profile, profileViewModel: profileViewModel)
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
            } // End ScrollView1
            .navigationTitle("My cocktails")
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.visible, for: .tabBar)
        } // End ZStack
        .onAppear{
            сocktailViewModel.getNewCocktail()
        }
    } // End Body
}

