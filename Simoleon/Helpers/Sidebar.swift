//
//  Sidebar.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 26/10/21.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        List {
            NavigationLink(destination: ConversionView()) {
                Label("Convert", systemImage: "arrow.counterclockwise.circle")
            }
            
            NavigationLink(destination: FavoritesView()) {
                Label("Favorites", systemImage: "star")
            }
            
            NavigationLink(destination: AboutView()) {
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
