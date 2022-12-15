//
//  ProfileView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 11.12.2022.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        ZStack {
            WallpaperView()
            Text("Hello")
                .foregroundColor(.white)
            
        }
        .toolbar {
            Button(action: {}) {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(Color("neonOrange"))
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
