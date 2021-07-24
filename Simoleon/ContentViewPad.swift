//
//  ContentViewPad.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI
import Purchases

struct ContentViewPad: View {
    @StateObject var subscriptionController = SubscriptionController()
    
    var body: some View {
        NavigationView {
            Sidebar()
                .environmentObject(subscriptionController)
            
            Conversion(fetchUserSettings: true, currencyPair: "USD/GBP")
                .environmentObject(subscriptionController)
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
}

struct ContentViewPad_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewPad()
    }
}
