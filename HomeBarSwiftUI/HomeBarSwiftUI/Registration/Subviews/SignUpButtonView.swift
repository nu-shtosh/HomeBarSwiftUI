//
//  SignUpButtonView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 08.12.2022.
//

import SwiftUI

struct SignUpButtonView: View {
    let action: ()
    let title: String

    var body: some View {
            VStack {
                Button(action: {action}) {
                    Text(title)
                        .font(.system(size: 22))
                }
                .foregroundColor(Color("neonBlue"))
            }

        }
}

struct RegisterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpButtonView(action: print("Sign Up"), title: "Sign Up")
    }
}
