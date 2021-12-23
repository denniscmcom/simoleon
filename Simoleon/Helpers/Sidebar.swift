//
//  Sidebar.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 23/12/21.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        List {
            NavigationLink(destination: ConversionView()) {
                Label("Convert", systemImage: "arrow.counterclockwise.circle")
            }
            
            NavigationLink(destination: Text("Favorites View")) {
                Label("Favorites", systemImage: "star")
            }
            
            NavigationLink(destination: Text("About")) {
                Label("About", systemImage: "info.circle")
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Categories")

    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
