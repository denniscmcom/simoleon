//
//  ContentView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 26/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello world")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
