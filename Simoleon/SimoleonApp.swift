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
    let fileController = FileController()
    
    init() {
        let apiKey = fileController.readConfigVariable(withKey: "PURCHASES_KEY")!
        Purchases.configure(withAPIKey: apiKey)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
