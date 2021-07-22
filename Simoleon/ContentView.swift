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
                    Label("Convert", systemImage: "arrow.counterclockwise.circle")
                }
                .tag(Tab.convert)
            
            Favourites()
                .tabItem {
                    Label("Favourites", systemImage: "star")
                }
                .tag(Tab.favourites)
            
            Settings()
                .environmentObject(subscriptionController)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(Tab.settings)
        }
        .onAppear(perform: checkEntitlements)
    }
    
    private func checkEntitlements() {
        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            if purchaserInfo?.entitlements["all"]?.isActive == true {
                print("User's subscription is active")
                self.subscriptionController.isActive = true
            } else {
                print("User's subscription expired or doesn't exist")
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
    }
}
