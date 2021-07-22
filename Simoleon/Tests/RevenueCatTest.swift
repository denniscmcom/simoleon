//
//  RevenueCatTest.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 21/07/2021.
//

import SwiftUI
import Purchases

struct RevenueCatTest: View {
    @State private var productName = ""
    @State private var price = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(productName)
            Text(price)
            Button("Buy", action: purchaseProMonthlySubscription)
        }
        .onAppear(perform: fetchProMonthlySubscription)
    }
    
    private func fetchProMonthlySubscription() {
        Purchases.shared.offerings { (offerings, error) in
            if let product = offerings?.current?.monthly?.product {
                self.productName = product.localizedTitle
                self.price = formatCurrency(product.priceLocale, product.price)
            }
        }
    }
    
    private func purchaseProMonthlySubscription() {
        Purchases.shared.offerings { (offerings, error) in
            if let package = offerings?.current?.monthly {
                Purchases.shared.purchasePackage(package) { (transaction, purchaserInfo, error, userCancelled) in
                    if purchaserInfo?.entitlements["all"]?.isActive == true {
                        print("Ok")
                    }
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
            // Handle error
            return ""
        }
    }
}

struct RevenueCatTest_Previews: PreviewProvider {
    static var previews: some View {
        RevenueCatTest()
    }
}
