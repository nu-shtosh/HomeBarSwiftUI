//
//  LogoView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("HomeBarLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
