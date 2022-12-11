//
//  TextFieldWithImageView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 11.12.2022.
//

import SwiftUI

struct TextFieldWithImageView: View {
    let title: String
    let imageSystemName: String
    @Binding var text: String

    var body: some View {
        TextField(title, text: $text)
            .textFieldStyle(GradientTextFieldBackgroundWithImage(systemImageString: imageSystemName))
    }
}

struct TextFieldWithImageView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithImageView(title: "Title", imageSystemName: "figure.kickboxing", text: .constant(""))
    }
}
