//
//  ContentView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var tab: Tab = .convert
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var defaultCurrency: FetchedResults<DefaultCurrency>
    
    var body: some View {
        TabView(selection: $tab) {
            Conversion(currencyPair: defaultCurrency.first?.pair ?? "USD/GBP")
                .tabItem {
                    Text("Convert", comment: "Tab bar button to show conversion")
                    Image(systemName: "arrow.counterclockwise.circle")
                }
                .tag(Tab.convert)
            
            Favourites()
                .tabItem {
                    Text("Favourites", comment: "Tab bar button to show favourites")
                    Image(systemName: "star")
                }
                .tag(Tab.favourites)
            
            Settings()
                .tabItem {
                    Text("Settings", comment: "Tab bar button to show settings")
                    Image(systemName: "gear")
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
