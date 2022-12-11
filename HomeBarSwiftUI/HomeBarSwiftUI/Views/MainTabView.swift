//
//  TabView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 11.12.2022.
//

import SwiftUI

struct MainTabView: View {
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
            ProfileView()
                .tabItem {
                    VStack {
                        Text("Profile")
                        Image(systemName: "person")
                    }
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
