//
//  AdventurePropertyStoreApp.swift
//  AdventurePropertyStore
//
//  Created by Ingmar Drewing on 29.04.23.
//

import SwiftUI

@main
struct AdventurePropertyStoreApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
