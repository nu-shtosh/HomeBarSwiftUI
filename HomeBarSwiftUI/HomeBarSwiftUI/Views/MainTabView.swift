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
                NavigationView() {
                    AllCocktailsView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle(Text("Cocktails"))
                    //                    .accentColor(Color("neonOrange"))
                }
                .tabItem {
                    VStack {
                        Text("Cocktails")
                        Image(systemName: "heart")
                    }
                }
                AlcoholTestView()
                    .tabItem {
                        VStack {
                            Text("Alcotest")
                            Image(systemName: "filemenu.and.selection")
                        }
                    }
                NavigationView() {
                    ProfileView()
                        .navigationBarTitleDisplayMode(.large)
//                        .navigationTitle(Text("Profile"))
                }
                .tabItem {
                    VStack {
                        Text("Profile")
                        Image(systemName: "person")
                    }
                }
            }
            .accentColor(Color("neonOrange"))
            .onAppear() {
                UITabBar.appearance().backgroundColor = .black
                UITabBar.appearance().barTintColor = .gray
                NavTheme.navigationBarColors(background: .black,
                                             titleColor: UIColor(Color("neonOrange")),
                                             tintColor: UIColor(Color("neonOrange")))
            }
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
