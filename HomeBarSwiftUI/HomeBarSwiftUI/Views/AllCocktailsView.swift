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

    // MARK: - State Properties
    @State var isHidden = false

    // MARK: - Private Properties
    private let layout = [GridItem(.adaptive(minimum: screen.width / 2.2))]

    // MARK: - Body
    var body: some View {
        ZStack {
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
                    } // LazyVGrid
                } // Section
                .foregroundColor(Color("neonBlue"))
            } // ScrollView
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.visible, for: .tabBar)
        } // ZStack
        .onAppear{
            cocktailViewModel.getCocktail()
        }
    }
}
