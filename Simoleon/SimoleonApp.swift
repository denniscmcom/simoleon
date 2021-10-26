//
//  SimoleonApp.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 26/10/21.
//

import SwiftUI

@main
struct SimoleonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
