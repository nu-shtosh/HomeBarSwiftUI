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
    @State private var image = Data()
    @State private var flag = false
    @State var coincidence = 0

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
//                if newCocktailViewModel.cocktail.idUser == profileViewModel.profile.id {
                    Section {
                        LazyVGrid(columns: layout, spacing: 5) {
                            ForEach(Array(newCocktailViewModel.allCocktails), id: \.name) { item in
                                if profileViewModel.profile.id == item.idUser {
                                    NavigationLink {
                                        CocktailDetailView(cocktail: item, profile: profileViewModel.profile, profileViewModel: profileViewModel)
                                            .navigationTitle(item.name)
                                           
                                    } label: {
                                        withAnimation {
                                            CocktailCellView(cocktail: item, flag: $flag)
                                        }
                                    }
                                } else if coincidence == 0 {
                                    LabelView(text: "No cocktail")
                                }
                            }
                        } // End LazyVGrid
                    } // End Section
                    .foregroundColor(Color("neonBlue"))
//                } else {
//                    LabelView(text: "no added cocktails")
//                }
            } // End ScrollView1
            .navigationTitle("My cocktails")
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.visible, for: .tabBar)
        } // End ZStack
        .onAppear{
           
            print(profileViewModel.profile.id)
            print(newCocktailViewModel.cocktail.idUser)
            
        }
    } // End Body
}

