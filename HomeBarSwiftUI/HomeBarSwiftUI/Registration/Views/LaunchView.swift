//
//  LaunchView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack {
            WallpaperView()
            VStack {
                LogoView()
                // тут будет анимация ?
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
