//
//  SubscriberInfo.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 22/07/2021.
//

import SwiftUI
import Purchases

struct SubscriberInfo: View {
    @State private var memberSince: Date? = nil
    @State private var expiration: Date? = nil
    @State private var latestPurchase: Date? = nil
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            List {
                if let memberSince = self.memberSince {
                    Text("Member since \(formatDate(memberSince))", comment: "Subscriber information")
                } else {
                    Text("-")
                }
                
                if let expiration = self.expiration {
                    Text("Expires at \(formatDate(expiration))", comment: "Subscriber information")
                } else {
                    Text("-")
                }
                
                if let latestPurchase = self.latestPurchase {
                    Text("Latest purchase \(formatDate(latestPurchase))", comment: "Subscriber information")
                } else {
                    Text("-")
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle(Text("Information", comment: "Navigation title"))
        .onAppear(perform: getInfo)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok", comment: "Dismiss alert")))
        }
    }
    
    private func getInfo() {
        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            self.memberSince = purchaserInfo?.entitlements["all"]?.originalPurchaseDate
            self.expiration = purchaserInfo?.entitlements["all"]?.expirationDate
            self.latestPurchase = purchaserInfo?.entitlements["all"]?.latestPurchaseDate

            if let error = error as NSError? {
                alertTitle = error.localizedDescription
                alertMessage = error.localizedFailureReason ?? ""
                showingAlert = true
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        let dateString = formatter.string(from: date)
        
        return dateString
    }
}

struct SubscriberInfo_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberInfo()
            .environmentObject(SubscriptionController())
    }
}
