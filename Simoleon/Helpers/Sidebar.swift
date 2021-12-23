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
            NavigationLink(destination:
                ConversionView(
                    baseCurrency: SupportedCurrencyResult(code: "EUR", name: "Euro", isCrypto: 0),
                    quoteCurrency: SupportedCurrencyResult(code: "USD", name: "U.S. Dollar", isCrypto: 0)
                )
            ) {
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
