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
    @EnvironmentObject var subscriptionController: SubscriptionController
    
    @State private var restoringPurchases = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        Button(action: restorePurchases) {
            if restoringPurchases {
                ProgressView()
            } else {
                Text("Restore purchases")
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    private func restorePurchases() {
        restoringPurchases = true
        
        Purchases.shared.restoreTransactions { purchaserInfo, error in
            if purchaserInfo?.entitlements["all"]?.isActive == true {
                subscriptionController.isActive = true
                showingSubscriptionPaywall = false
            } else {
                alertTitle = "No subscriptions found"
                alertMessage = "You are not subscripted to Simoleon yet."
                restoringPurchases = false
                showingAlert = true
            }
            
            if let error = error as NSError? {
                alertTitle = error.localizedDescription
                alertMessage = error.localizedFailureReason ?? "If the problem persists send an email to dmartin@dennistech.io"
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
