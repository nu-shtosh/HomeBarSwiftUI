//
//  LaunchView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 04.12.2022.
//

import SwiftUI

struct LaunchView: View {

    @State private var angle: Double = 0

    var logoImage = "HomeBarLogo"

    var body: some View {
        VStack() {
            Image(logoImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .background(Color.black)
    }
}
