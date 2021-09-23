//
//  ContentView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var tab: Tab = .convert
    
    private enum Tab {
        case convert, favorites, settings
    }
    
    @ViewBuilder var adjustedView: some View {
        
        // MARK: - iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            NavigationView {
                Sidebar()
                ConversionView()
            }
        } else {
            // MARK: - iPhone
            TabView(selection: $tab) {
                ConversionView()
                    .tabItem {
                        Label("Convert", systemImage: "arrow.counterclockwise.circle")
                    }
                    .tag(Tab.convert)
                
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
                    .tag(Tab.favorites)

                AboutView()
                    .tabItem {
                        Label("About", systemImage: "info.circle")
                    }
                    .tag(Tab.settings)
            }
        }
    }
    
    var body: some View {
        adjustedView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
