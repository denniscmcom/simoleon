//
//  ContentView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var defaultCurrency: FetchedResults<DefaultCurrency>
    
    @State private var tab: Tab = .convert
    
    private enum Tab {
        case convert, favorites, settings
    }
    
    var body: some View {
        TabView(selection: $tab) {
            Conversion(currencyPair: defaultCurrency.first?.pair ?? "USD/GBP")
                .tabItem {
                    Label("Convert", systemImage: "arrow.counterclockwise.circle")
                }
                .tag(Tab.convert)
                .accessibilityIdentifier("Convert")
            
            Favorites()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(Tab.favorites)
                .accessibilityIdentifier("Favorites")
            
            Settings()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(Tab.settings)
                .accessibilityIdentifier("Settings")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, Locale(identifier: "es"))
    }
}
