//
//  ContentView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var tab: Tab = .convert
    var body: some View {
        TabView(selection: $tab) {
            Conversion()
                .tabItem {
                    Label("Convert", systemImage: "arrow.counterclockwise.circle")
                }
                .tag(Tab.convert)
            
            Favourites()
                .tabItem {
                    Label("Favourites", systemImage: "star")
                }
                .tag(Tab.favourites)
            
            Settings()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(Tab.settings)
        }
    }
    
    private enum Tab {
        case convert, favourites, settings
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
