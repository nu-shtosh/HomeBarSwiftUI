//
//  AlcotestView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 11.12.2022.
//

import SwiftUI

struct AlcoholTestView: View {
    var body: some View {
        ZStack {
            WallpaperView()
            VStack {
                CustomSegmentedPickerView()
                Spacer()
            }
            .padding()
        }
    }
}


struct AlcoholTestView_Previews: PreviewProvider {
    static var previews: some View {
        AlcoholTestView()
    }
}
