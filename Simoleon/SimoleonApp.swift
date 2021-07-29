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
    let persistenceController = PersistenceController.shared
    
    init() {
        Purchases.configure(withAPIKey: "\(readConfig("PURCHASES_KEY")!)")
    }
    
    var body: some Scene {
        WindowGroup {
            if UIDevice.current.userInterfaceIdiom == .pad {
                ContentViewPad()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}

