//
//  HomeBarSwiftUIApp.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 04.12.2022.
//

import SwiftUI

@main
struct HomeBarSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
