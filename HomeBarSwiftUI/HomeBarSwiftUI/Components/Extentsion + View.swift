//
//  Extentsion + View.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 24.03.2023.
//

import SwiftUI

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
