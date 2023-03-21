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

    @State var isHidden = false
    
    var body: some View {
        ZStack {
            WallpaperView()
            ScrollView(.vertical, showsIndicators: false) {
                Section {
                    LazyVGrid(columns: layout, spacing: 5) {
                        ForEach(cocktailViewModel.cocktail, id: \.name) { item in
                            NavigationLink {
                                CocktailDetailView(cocktail: item)
                                    .navigationTitle(item.name)
                            } label: {
                                withAnimation {
                                    CocktailCellView(cocktail: item)
                                }
                            }
                        }
                    }
                }
                .foregroundColor(Color("neonBlue"))
            }
            .toolbar(.visible, for: .tabBar)
        }
        .onAppear{
            cocktailViewModel.getCocktail()
        }
    }
}

//
//struct AllCocktailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllCocktailsView(cocktailViewModel: <#CocktailsViewModel#>)
//    }
//}
