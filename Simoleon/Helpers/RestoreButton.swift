//
//  RestoreButton.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 22/07/2021.
//

import SwiftUI
import Purchases

struct RestoreButton: View {
    @Binding var showingSubscriptionPaywall: Bool
    
    @State private var alertTitle: LocalizedStringKey = ""
    @State private var alertMessage: LocalizedStringKey = ""
    @State private var restoringPurchases = false
    @State private var showingAlert = false
    
    var body: some View {
        Button(action: restorePurchases) {
            if restoringPurchases {
                ProgressView()
            } else {
                Text("Restore purchases", comment: "Button to restore in-App purchases")
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok", comment: "Button to dismiss alert")))
        }
    }
    
    private func restorePurchases() {
        restoringPurchases = true
        
        Purchases.shared.restoreTransactions { purchaserInfo, error in
            if purchaserInfo?.entitlements["all"]?.isActive == true {
                showingSubscriptionPaywall = false
            } else {
                alertTitle = LocalizedStringKey("No subscriptions found")
                alertMessage = LocalizedStringKey("You are not subscripted to Simoleon yet.")
                restoringPurchases = false
                showingAlert = true
            }
            
            if let error = error as NSError? {
                alertTitle = LocalizedStringKey(error.localizedDescription)
                alertMessage = LocalizedStringKey(error.localizedFailureReason ?? "")
                showingAlert = true
            }
        }
    }
}

struct RestoreButton_Previews: PreviewProvider {
    static var previews: some View {
        RestoreButton(showingSubscriptionPaywall: .constant(true))
    }
}
