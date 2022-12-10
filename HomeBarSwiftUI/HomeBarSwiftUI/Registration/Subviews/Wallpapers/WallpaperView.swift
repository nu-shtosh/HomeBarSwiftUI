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
            .aspectRatio(UIImage(named: "HomeBarWallpaper")?.size ?? CGSize(width: 100, height: 100), contentMode: .fill)
            .background(Color.black)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
    }
}

struct WallpaperView_Previews: PreviewProvider {
    static var previews: some View {
        WallpaperView()
    }
}
