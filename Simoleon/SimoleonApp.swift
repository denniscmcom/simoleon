//
//  SimoleonApp.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 08/07/2021.
//

import SwiftUI
import Purchases

@main
struct SimoleonApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    
    init() {
        Purchases.configure(withAPIKey: "\(readConfig("PURCHASES_KEY")!)")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
