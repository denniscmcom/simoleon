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
            NavigationLink(destination: ConversionView()) {
                Label("Convert", systemImage: "arrow.counterclockwise.circle")
            }
            .accessibilityIdentifier("NavigateToConversion")
            
            NavigationLink(destination: FavoritesView()) {
                Label("Favorites", systemImage: "star")
            }
            .accessibilityIdentifier("NavigateToFavorites")
            
            NavigationLink(destination: AboutView()) {
                Label("About", systemImage: "gear")
            }
            .accessibilityIdentifier("NavigateToSettings")
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Categories")
        .accessibilityIdentifier("Sidebar")
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Sidebar()
        }
    }
}
