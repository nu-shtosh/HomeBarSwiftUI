//
//  TabView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 11.12.2022.
//

import SwiftUI

struct MainTabView: View {
    
    // MARK: - Properties
    @State var isActive = false
    let tabBarViewModel: MainTabBarViewModel
    let ingredientsViewModel = IngredientsViewModel(
        allIngredients: [IngredientDB(name: "")]
    )
    let cocktailsViewModel =  CocktailsViewModel(
        allCocktails: [CocktailDB(
            name: "",
            tags: "",
            alcoholic: "",
            instructions: "",
            image: "",
            ingredientsNames: [""],
            ingredientsMeasures: [""],
            rating: 0,
            numberOfRatings: 0,
            sumOfRating: 0,
            userRating: 0,
            likes: 0,
            comments: ["" : ""], idUser: ""
        )], cocktail: CocktailDB(
            name: "",
            tags: "",
            alcoholic: "",
            instructions: "",
            image: "",
            ingredientsNames: [""],
            ingredientsMeasures: [""],
            rating: 0,
            numberOfRatings: 0,
            sumOfRating: 0,
            userRating: 0,
            likes: 0,
            comments: ["" : ""], idUser: ""
        ),
        image: Data()
    )
    let newCocktailViewModel = NewCocktailsViewModel(
        allCocktails: [CocktailDB(
            name: "",
            tags: "",
            alcoholic: "",
            instructions: "",
            image: "",
            ingredientsNames: [""],
            ingredientsMeasures: [""],
            rating: 0,
            numberOfRatings: 0,
            sumOfRating: 0,
            userRating: 0,
            likes: 0,
            comments: ["" : ""], idUser: ""
        )], cocktail: CocktailDB(
            name: "",
            tags: "",
            alcoholic: "",
            instructions: "",
            image: "",
            ingredientsNames: [""],
            ingredientsMeasures: [""],
            rating: 0,
            numberOfRatings: 0,
            sumOfRating: 0,
            userRating: 0,
            likes: 0,
            comments: ["" : ""], idUser: ""
        ),
        image: Data()
    )
    let profileViewModel = ProfileViewModel(
        profile: UserDB(id: "1",
                        name: "",
                        surname: "",
                        age: "",
                        email: "",
                        favoritesCocktails: [])
    )
    let alcoTestViewModel = AlcoTestViewModel()
    
    // MARK: - Body
    var body: some View {
        TabView {
            Group {
                // MARK: - Ingredients
                NavigationStack {
                    AllIngredientsView(
                        ingredientsViewModel: ingredientsViewModel,
                        profileViewModel: profileViewModel,
                        newCocktailViewModel: newCocktailViewModel,
                        cocktailViewModel: cocktailsViewModel
                    )
                    .navigationTitle(Text("Ingredients"))
                }
                .tabItem {
                    VStack {
                        Text("Ingredients")
                        Image(systemName: "heart")
                    }
                } // End NavStack
                
                // MARK: - Cocktails
                NavigationStack {
                    AllCocktailsView(
                        cocktailViewModel: cocktailsViewModel,
                        profileViewModel: profileViewModel,
                        newCocktailViewModel: newCocktailViewModel
                    )
                    .navigationTitle(Text("Cocktails"))
                    
                }
                .tabItem {
                    VStack {
                        Text("Cocktails")
                        Image(systemName: "heart")
                    }
                } // End NavStack
                
                // MARK: - AlcoTest
                NavigationStack() {
                    AlcoholTestView(alcoTestViewModel: alcoTestViewModel)
                        .navigationTitle(Text("Alcotest"))
                }
                .tabItem {
                    VStack {
                        Text("Alcotest")
                        Image(systemName: "filemenu.and.selection")
                    }
                } // End NavStack
                
                // MARK: - Profile
                NavigationStack() {
                    ProfileView(
                        profileViewModel: profileViewModel,
                        cocktailViewModel: cocktailsViewModel,
                        newCocktailViewModel: newCocktailViewModel,
                        ingredientsViewModel: ingredientsViewModel,
                        rootIsActive: $isActive
                    )
                }
                .tabItem {
                    VStack {
                        Text("Profile")
                        Image(systemName: "person")
                    }
                } // End NavStack
            } // End Group
            .tint(Color("neonOrange"))
            .accentColor(Color("neonOrange"))
            .foregroundColor(Color("neonOrange"))
            .onAppear() {
                NavTheme.navigationBarColors(
                    background: .black,
                    titleColor: UIColor(Color("neonOrange")),
                    tintColor: UIColor(Color("neonOrange"))
                )
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.black, for: .tabBar)
        } // End TabView
        .accentColor(Color("neonOrange"))
    } // End Body
}

// MARK: - Navigation Bar Setup
final class NavTheme {
    static func navigationBarColors(background : UIColor?, titleColor : UIColor? = nil, tintColor : UIColor? = nil) {
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .clear
        
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
        
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        
        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    }
}
