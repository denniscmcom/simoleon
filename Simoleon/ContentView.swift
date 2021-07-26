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
    
    var body: some View {
        TabView(selection: $tab) {
            Conversion(currencyPair: defaultCurrency.first?.pair ?? "USD/GBP")
                .tabItem {
                    Text("Convert", comment: "Tab bar button to show conversion")
                    Image(systemName: "arrow.counterclockwise.circle")
                }
                .tag(Tab.convert)
                .accessibilityIdentifier("Convert")
            
            Favourites()
                .tabItem {
                    Text("Favourites", comment: "Tab bar button to show favourites")
                    Image(systemName: "star")
                }
                .tag(Tab.favourites)
                .accessibilityIdentifier("Favourites")
            
            Settings()
                .tabItem {
                    Text("Settings", comment: "Tab bar button to show settings")
                    Image(systemName: "gear")
                }
                .tag(Tab.settings)
                .accessibilityIdentifier("Settings")
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
