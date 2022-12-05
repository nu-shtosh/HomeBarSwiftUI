//
//  LaunchView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 04.12.2022.
//

import SwiftUI

struct LaunchView: View {

    let homeBarLogoImage = "HomeBarLogo"

    var body: some View {
        VStack() {
            Image(homeBarLogoImage)
                .resizable()
                .frame(width: 200, height: 200)
            Spacer()
        }
        .frame(minWidth: 380)
        .background(Color.black)
    }
}

struct StartSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView().background(Color.black)
    }
}
