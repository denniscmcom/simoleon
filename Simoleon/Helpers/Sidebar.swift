//
//  Sidebar.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        List {
            NavigationLink(destination: Conversion()) {
                Label("Convert", systemImage: "arrow.counterclockwise.circle")
            }
            
            NavigationLink(destination: Text("Favourites")) {
                Label("Favourites", systemImage: "star")
            }
            
            NavigationLink(destination: Text("Settings")) {
                Label("Settings", systemImage: "gear")
            }
        }
        .listStyle(SidebarListStyle())
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
