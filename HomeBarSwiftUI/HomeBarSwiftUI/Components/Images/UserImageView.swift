//
//  UserImageView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 15.12.2022.
//

import SwiftUI

struct UserImageView: View {
    @Binding var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: screen.width / 2.1, height: screen.width / 2.1)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(LinearGradient(
                colors: [Color("neonOrange"), Color("neonBlue")],
                startPoint: .top,
                endPoint: .bottom
            ), lineWidth: 3))
    }
}

//struct UserImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserImageView(image: UIImage(systemName: "person"))
//    }
//}
