//
//  ContentView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 04.12.2022.
//
// xx
import SwiftUI
import FirebaseCore
import FirebaseAuth

struct ContentView: View {

    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

    var body: some View {
        VStack {
            if status {
                LaunchView()
            } else {
                SignInView()
            }
        }
//        .animation(.spring())
//            .onAppear {
//                NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
//                    <#code#>
//                }
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
