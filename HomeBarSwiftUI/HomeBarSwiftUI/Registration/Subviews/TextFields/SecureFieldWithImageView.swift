//
//  SecureFieldWithImageView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI

struct SecureFieldWithImageView: View {
    let title: String
    let imageSystemName: String
    @Binding var text: String

    var body: some View {
        SecureField(title, text: $text)
            .textFieldStyle(GradientTextFieldBackgroundWithImage(systemImageString: imageSystemName))
    }
}

struct SecureFieldWithImageView_Previews: PreviewProvider {
    static var previews: some View {
        SecureFieldWithImageView(title: "Title", imageSystemName: "key", text: .constant(""))
    }
}
