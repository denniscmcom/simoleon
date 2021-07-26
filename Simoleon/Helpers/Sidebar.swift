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
            NavigationLink(destination: Conversion(currencyPair: "USD/GBP")) {
                Label("Convert", systemImage: "arrow.counterclockwise.circle")
            }
            
            NavigationLink(destination: Favourites()) {
                Label("Favourites", systemImage: "star")
            }
            
            NavigationLink(destination: Settings()) {
                Label("Settings", systemImage: "gear")
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle(Text("Categories", comment: "Side bar navigation title"))
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
