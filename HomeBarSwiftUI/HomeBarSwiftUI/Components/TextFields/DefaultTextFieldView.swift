//
//  DefaultTextFieldView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI

struct DefaultTextFieldView: View {
    let title: String
    @Binding var text: String

    var body: some View {
        TextField(title, text: $text)
            .textFieldStyle(GradientTextFieldBackground())
    }
}

struct DefaultTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultTextFieldView(title: "Title", text: .constant(""))
    }
}
