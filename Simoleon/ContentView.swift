//
//  ContentView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI
import Purchases

struct ContentView: View {
    @State private var tab: Tab = .convert
    @StateObject var subscriptionController = SubscriptionController()
    
    var body: some View {
        TabView(selection: $tab) {
            Conversion(fetchUserSettings: true, currencyPair: "USD/GBP")
                .environmentObject(subscriptionController)
                .tabItem {
                    Text("Convert", comment: "Tab bar button to show conversion")
                    Image(systemName: "arrow.counterclockwise.circle")
                }
                .tag(Tab.convert)
            
            Favourites()
                .environmentObject(subscriptionController)
                .tabItem {
                    Text("Favourites", comment: "Tab bar button to show favourites")
                    Image(systemName: "star")
                }
                .tag(Tab.favourites)
            
            Settings()
                .environmentObject(subscriptionController)
                .tabItem {
                    Text("Settings", comment: "Tab bar button to show settings")
                    Image(systemName: "gear")
                }
                .tag(Tab.settings)
        }
        .onAppear(perform: checkEntitlements)
    }
    
    private func checkEntitlements() {
        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            if purchaserInfo?.entitlements["all"]?.isActive == true {
                self.subscriptionController.isActive = true
            } else {
                // User subscription is not active
            }
        }
    }
    
    private enum Tab {
        case convert, favourites, settings
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.locale, .init(identifier: "es"))
    }
}
