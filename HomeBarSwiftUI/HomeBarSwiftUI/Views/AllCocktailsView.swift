//
//  AllCocktailsView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 14.12.2022.
//

import SwiftUI

struct AllCocktailsView: View {
    
    @StateObject var cocktailViewModel: CocktailsViewModel
    
    let layout = [GridItem(.adaptive(minimum: screen.width / 2.2))]
    
    var body: some View {
        ZStack(){
            WallpaperView()
            ScrollView(.vertical, showsIndicators: false) {
                Section {
                    LazyVGrid(columns: layout, spacing: 12) {
                        ForEach(cocktailViewModel.cocktail, id: \.name) { item in
                            NavigationLink {
                                CocktailDetailView(cocktail: item)
                                    .navigationTitle(item.name)
                            } label: {
                                CocktailCellView(cocktail: item)
                            }
                        }
                    }
                }
                .foregroundColor(Color("neonBlue"))
                
            }
        }
        .onAppear{
            cocktailViewModel.getCocktail()
        }
    }
}

//struct AllCocktailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllCocktailsView(cocktailViewModel: <#CocktailsViewModel#>)
//    }
//}
