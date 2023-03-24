//
//  TabView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 11.12.2022.
//

import SwiftUI

struct MainTabView: View {

    // MARK: - Properties
    var tabBarViewModel: MainTabBarViewModel
    var ingredientsViewModel =  IngredientsViewModel(allIngredients: [IngredientDB(name: "")])
    var cocktailsViewModel =  CocktailsViewModel(allCocktails: [CocktailDB(name: "",
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
                                                                           comments: ["" : ""])],
                                                 image: Data())
    var profileViewModel = ProfileViewModel(profile: UserDB(id: "1",
                                                            name: "",
                                                            surname: "",
                                                            age: "",
                                                            email: ""))
    var alcoTestViewModel = AlcoTestViewModel()

    // MARK: - Body
    var body: some View {
        TabView {
            Group {
                // MARK: - Ingredients
                NavigationStack {
                    AllIngredientsView(ingredientsViewModel: ingredientsViewModel)
                        .navigationTitle(Text("Ingredients"))
                }
                .tabItem {
                    VStack {
                        Text("Ingredients")
                        Image(systemName: "heart")
                    }
                } // NavStack

                // MARK: - Cocktails
                NavigationStack {
                    AllCocktailsView(cocktailViewModel: cocktailsViewModel)
                        .navigationTitle(Text("Cocktails"))

                }
                .tabItem {
                    VStack {
                        Text("Cocktails")
                        Image(systemName: "heart")
                    }
                } // NavStack

                // MARK: - AlcoTest
                NavigationView() {
                    AlcoholTestView(alcoTestViewModel: alcoTestViewModel)
                        .navigationTitle(Text("Alcotest"))
                }
                .tabItem {
                    VStack {
                        Text("Alcotest")
                        Image(systemName: "filemenu.and.selection")
                    }
                } // NavStack

                // MARK: - Profile
                NavigationView() {
                    ProfileView(profileViewModel: profileViewModel,
                                cocktailViewModel: cocktailsViewModel)
                }
                .tabItem {
                    VStack {
                        Text("Profile")
                        Image(systemName: "person")
                    }
                } // NavStack


                /*
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
                 */

            } // Group
            .tint(Color("neonOrange"))
            .accentColor(Color("neonOrange"))
            .onAppear() {
                NavTheme.navigationBarColors(background: .black,
                                             titleColor: UIColor(Color("neonOrange")),
                                             tintColor: UIColor(Color("neonOrange")))
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.black, for: .tabBar)

        } // TabView
        .accentColor(Color("neonOrange"))
    }
}



// MARK: - Navigation Bar Setup
final class NavTheme {
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
