//
//  WallpaperView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI

struct WallpaperView: View {
    var body: some View {
        Image("HomeBarWallpaper")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .background(Color.black)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}

struct WallpaperView_Previews: PreviewProvider {
    static var previews: some View {
        WallpaperView()
    }
}
