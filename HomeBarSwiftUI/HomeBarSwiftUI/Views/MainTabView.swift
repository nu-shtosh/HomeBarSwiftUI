//
//  TabView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 11.12.2022.
//

import SwiftUI

struct MainTabView: View {

    var viewModel: MainTabBarViewModel
    
    var body: some View {
        TabView {
            Group {

                // MARK: - Fetch Get
                NavigationStack {
                    IngredientsView()
                }
                .tabItem {
                    VStack {
                        Text("Fetch")
                        Image(systemName: "flag.checkered.circle.fill")
                    }
                }

                // MARK: - Ingredients
                NavigationStack {
                    AllIngredientsView(ingredientsViewModel: IngredientsViewModel(allIngredients: [IngredientDB(name: "")]))
                        .navigationTitle(Text("Ingredients"))
                }
                .tabItem {
                    VStack {
                        Text("Ingredients")
                        Image(systemName: "heart")
                    }
                }

                // MARK: - Cocktails
                NavigationStack {
                    AllCocktailsView(cocktailViewModel: CocktailsViewModel(allCocktails: [CocktailDB(
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
                        comments: ["" : ""]
                    )], image: Data()))
                    .navigationTitle(Text("Cocktails"))

                }
                .tabItem {
                    VStack {
                        Text("Cocktails")
                        Image(systemName: "heart")
                    }
                }

                // MARK: - AlcoTest
                NavigationView() {
                    AlcoholTestView(alcoTestViewModel: AlcoTestViewModel())
                    .navigationTitle(Text("Alcotest"))
                }
                .tabItem {
                    VStack {
                        Text("Alcotest")
                        Image(systemName: "filemenu.and.selection")
                    }
                }

                // MARK: - Profile
                NavigationView() {
                    ProfileView(profileViewModel: ProfileViewModel(profile: UserDB(
                        id: "1",
                        name: "",
                        surname: "",
                        age: "",
                        email: ""
                    )), cocktailViewModel: CocktailsViewModel(allCocktails: [CocktailDB(
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
                        comments: ["" : ""]
                    )], image: Data()))
                    // надо функцию написать, чтобы она возвращала экземпляр модели и не городить эту херню
                    //                        .navigationTitle(Text("Profile"))
                }
                .tabItem {
                    VStack {
                        Text("Profile")
                        Image(systemName: "person")
                    }
                }
            }
            .tint(Color("neonOrange"))
            .accentColor(Color("neonOrange"))
            .onAppear() {
                NavTheme.navigationBarColors(background: .black,
                                             titleColor: UIColor(Color("neonOrange")),
                                             tintColor: UIColor(Color("neonOrange")))
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.black, for: .tabBar)

        }
        .accentColor(Color("neonOrange"))

    }
}

class NavTheme {
    static func navigationBarColors(background : UIColor?,
                                    titleColor : UIColor? = nil,
                                    tintColor : UIColor? = nil ){
        
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
