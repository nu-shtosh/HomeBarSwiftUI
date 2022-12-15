//
//  HomeBarSwiftUIApp.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 04.12.2022.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

let screen = UIScreen.main.bounds

@main
struct HomeBarSwiftUIApp: App {
    

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            SignInView()
        }
    }

    class AppDelegate: NSObject, UIApplicationDelegate {

        func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
        ) -> Bool {
            FirebaseApp.configure()
            print("App Delegate")
            return true
        }
    }
}
