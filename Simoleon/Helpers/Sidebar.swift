//
//  Sidebar.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI

struct Sidebar: View {
    @EnvironmentObject var subscriptionController: SubscriptionController
    
    var body: some View {
        List {
            NavigationLink(destination: Conversion(fetchUserSettings: true, currencyPair: "USD/GBP")
                            .environmentObject(subscriptionController)
            ) {
                Label("Convert", systemImage: "arrow.counterclockwise.circle")
            }
            
            NavigationLink(destination: Favourites()
                            .environmentObject(subscriptionController)
            ) {
                Label("Favourites", systemImage: "star")
            }
            
            NavigationLink(destination: Settings()
                            .environmentObject(subscriptionController)
            ) {
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
