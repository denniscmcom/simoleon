//
//  SubscribeButton.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 22/07/2021.
//

import SwiftUI
import Purchases

struct SubscribeButton: View {
    @Binding var showingSubscriptionPaywall: Bool
    
    @State private var price = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var showingPrice = false
    
    var body: some View {
        Button(action: purchaseMonthlySubscription) {
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 60)
                .overlay(
                    VStack {
                        if showingPrice {
                            Text("Subscribe for \(price) / month", comment: "Subscribe button")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        } else {
                            ProgressView()
                        }
                    }
                )
        }
        .onAppear(perform: fetchMonthlySubscription)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    private func fetchMonthlySubscription() {
        Purchases.shared.offerings { (offerings, error) in
            if let product = offerings?.current?.monthly?.product {
                price = formatCurrency(product.priceLocale, product.price)
                showingPrice = true
            }
            
            if let error = error as NSError? {
                alertTitle = error.localizedDescription
                alertMessage = error.localizedFailureReason ?? ""
                price = "-"
                showingPrice = true
                showingAlert = true
            }
        }
    }
    
    private func purchaseMonthlySubscription() {
        showingPrice = false
        
        Purchases.shared.offerings { (offerings, error) in
            if let package = offerings?.current?.monthly {
                
                Purchases.shared.purchasePackage(package) { (transaction, purchaserInfo, error, userCancelled) in
                    if purchaserInfo?.entitlements["all"]?.isActive == true {
                        showingPrice = true
                        showingSubscriptionPaywall = false
                    }
                    
                    if let error = error as NSError? {
                        alertTitle = error.localizedDescription
                        alertMessage = error.localizedFailureReason ?? ""
                        showingPrice = true
                        showingAlert = true
                    }
                }
                
                if let error = error as NSError? {
                    alertTitle = error.localizedDescription
                    alertMessage = error.localizedFailureReason ?? ""
                    showingPrice = true
                    showingAlert = true
                }
            }
        }
    }
    
    private func formatCurrency(_ locale: Locale, _ amount: NSDecimalNumber) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        
        if let formattedAmount = formatter.string(from: amount as NSNumber) {
            return formattedAmount
        } else {
            return "\(amount)\(locale.currencySymbol!)"
        }
    }
}

struct SubscribeButton_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeButton(showingSubscriptionPaywall: .constant(true))
    }
}
