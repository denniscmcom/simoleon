//
//  SimoleonApp.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 08/07/2021.
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
