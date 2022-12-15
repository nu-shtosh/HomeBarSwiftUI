//
//  UserImageView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 15.12.2022.
//

import SwiftUI

struct UserImageView: View {
    var body: some View {
        Image("photo")
            .resizable()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay(Circle().stroke(LinearGradient(
                colors: [
                    Color("neonOrange"),
                    Color("neonBlue")
                ],
                startPoint: .top,
                endPoint: .bottom
            ),
            lineWidth: 3
            ))
    }
}

struct UserImageView_Previews: PreviewProvider {
    static var previews: some View {
        UserImageView()
    }
}
