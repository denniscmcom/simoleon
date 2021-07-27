//
//  SimoleonApp.swift
//  SimoleonWatchOS Extension
//
//  Created by Dennis Concepción Martín on 27/07/2021.
//

import SwiftUI

@main
struct SimoleonApp: App {
    let persistenceController = PersistenceController.shared
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
