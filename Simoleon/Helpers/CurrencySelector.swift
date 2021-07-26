//
//  CurrencySelector.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI
import Purchases

struct CurrencySelector: View {
    @Binding var currencyPair: String
    @Binding var showingCurrencySelector: Bool
    
    @State private var searchCurrency = ""
    @State private var showingSubscriptionPaywall = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Search ...", text: $searchCurrency)
                    .accessibilityIdentifier("SearchBar")
                
                Section(header: Text("All currencies", comment: "Section header in currency selector")) {
                    ForEach(currencyPairs(), id: \.self) { currencyPair in
                        Button(action: { select(currencyPair) }) {
                            CurrencyRow(currencyPair: currencyPair)
                        }
                    }
                }
            }
            .gesture(DragGesture()
                        .onChanged({ _ in
                            UIApplication.shared.dismissKeyboard()
                        })
            )
            .sheet(isPresented: $showingSubscriptionPaywall) {
                SubscriptionPaywall(showingSubscriptionPaywall: $showingSubscriptionPaywall)
            }
            .navigationTitle(Text("Currencies", comment: "Navigation title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { showingCurrencySelector = false }) {
                        Text("Cancel", comment: "Button to dismiss currency selector")
                    }
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    /*
     If searched currency string is empty:
     * Show all currencies
     else:
     * Show filtered list of currencies containing searched currency string
     */
    private func currencyPairs() -> [String] {
        let currencyPairs: [String] = parseJson("CurrencyPairs.json")
        
        if searchCurrency.isEmpty {
            return currencyPairs
        } else {
            return currencyPairs.filter { $0.contains(searchCurrency.uppercased()) }
        }
    }
    
    
    /*
     If user is subscribed:
     * Select currency and dismiss currency selector
     else:
     * Show subscription paywall
     */
    private func select(_ currencyPair: String) {
        #if targetEnvironment(simulator)
        // We're in simulator
        self.currencyPair = currencyPair
        showingCurrencySelector = false
        #else
        // We're in physical device
        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            if purchaserInfo?.entitlements["all"]?.isActive == true {
                self.currencyPair = currencyPair
                showingCurrencySelector = false
            } else {
                showingSubscriptionPaywall = true
            }
            
            if let error = error as NSError? {
                alertTitle = error.localizedDescription
                alertMessage = error.localizedFailureReason ?? ""
                showingAlert = true
            }
        }
        #endif
    }
}


struct CurrencySelector_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelector(currencyPair: .constant("USD/GBP"), showingCurrencySelector: .constant(false))
    }
}
