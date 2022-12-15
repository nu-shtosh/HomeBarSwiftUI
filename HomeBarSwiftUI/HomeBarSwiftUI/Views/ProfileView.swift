//
//  ProfileView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 11.12.2022.
//

import SwiftUI

struct ProfileView: View {
    
//    init() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "neonOrange")!]
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "neonOrange")!]
//        UINavigationBar.appearance().backgroundColor = .black
//        }
    
    var body: some View {
        NavigationView {
            ZStack {
                WallpaperView()
                Text("Hello")
                    .foregroundColor(.white)
                    
            }
            .navigationTitle("Navigation Title")
            .navigationBarTitleTextColor(Color("neonOrange"))
            toolbar {
                            Button(action: {}) {
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(Color("neonOrange"))
                            }
                        }
//                        .navigationTitle("Navigation Title")
//                        .toolbarBackground(Color(.black), for: .navigationBar)
//                        .toolbarBackground(.visible, for: .navigationBar)
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension View {
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
}
