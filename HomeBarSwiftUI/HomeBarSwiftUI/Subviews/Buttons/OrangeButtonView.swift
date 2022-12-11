//
//  LogInButtonView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI

struct OrangeButtonView: View {
    let action: () -> Void
    let title: String

    var body: some View {
            VStack {
                Button(action: action) {
                    Text(title)
                        .font(.system(size: 22))
                }
                .frame(width: 300, height: 50)
                .background(Color("neonOrange"))
                .foregroundColor(.white)
                .cornerRadius(8)
            }

        }
}

struct LogInButtonView_Previews: PreviewProvider {
    static var previews: some View {
        OrangeButtonView(action: {}, title: "Log In")
    }
}
