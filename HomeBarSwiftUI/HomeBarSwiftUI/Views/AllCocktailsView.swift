//
//  AllCocktailsView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 14.12.2022.
//

import SwiftUI

struct AllCocktailsView: View {

    let layout = [GridItem(.adaptive(minimum: screen.width / 2.2))]

    var body: some View {
        ZStack(){
            WallpaperView()
            ScrollView(.vertical, showsIndicators: false) {
                Section {
                        LazyVGrid(columns: layout, spacing: 12) {
                            ForEach(CocktailsViewModel.shared.drinks, id: \.id) { item in
                                NavigationLink {
                                    CocktailDetailView(cocktail: item)
                                        .navigationTitle(item.name)
                                } label: {
                                    CocktailCellView(cocktail: item)
                                }
                        }
                    }
                }.foregroundColor(Color("neonBlue"))
            }
        }
    }
}

struct AllCocktailsView_Previews: PreviewProvider {
    static var previews: some View {
        AllCocktailsView()
    }
}
