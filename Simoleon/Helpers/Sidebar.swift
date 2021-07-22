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
            NavigationLink(destination: Conversion(fetchUserSettings: true, currencyPair: "USD/GBP")) {
                HStack {
                    Text("Convert", comment: "Tab bar button to show conversion")
                    Image(systemName: "arrow.counterclockwise.circle")
                }
            }
            
            NavigationLink(destination: Favourites()) {
                HStack {
                    Text("Favourites", comment: "Tab bar button to show favourites")
                    Image(systemName: "star")
                }
            }
            
            NavigationLink(destination: Settings()) {
                HStack {
                    Text("Settings", comment: "Tab bar button to show settings")
                    Image(systemName: "gear")
                }
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
