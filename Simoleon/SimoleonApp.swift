//
//  simoleonApp.swift
//  simoleon
//
//  Created by Dennis Concepción Martín on 8/12/21.
//

import SwiftUI

@main
struct simoleonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
