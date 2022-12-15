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
            
            IngredientsView()
               
                .tabItem {
                    VStack {
                        Text("Ingredients")
                        Image(systemName: "testtube.2")
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
                    .navigationTitle(Text("Profile"))
            }
            .tabItem {
                VStack {
                    Text("Profile")
                    Image(systemName: "person")
                }
            }
        }
        .accentColor(Color("neonOrange"))
        
    }
}

