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
    
    @State private var entitlementIsActive = false
    @State private var searchCurrency = ""
    @State private var showingSubscriptionPaywall = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    /*
     If searched currency string is empty:
     * Show all currencies
     else:
     * Show filtered list of currencies containing searched currency string
     */
    var searchResults: [String] {
        let currencyPairsSupported: [String] = try! read(json: "CurrencyPairs.json")
        if searchCurrency.isEmpty {
            return currencyPairsSupported.sorted()
        } else {
            return currencyPairsSupported.filter { $0.contains(searchCurrency.uppercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(placeholder: "Search...", text: $searchCurrency)
                    .padding()
                    .accessibilityIdentifier("CurrencySearchBar")
                
                List {
                    if entitlementIsActive {
                        ForEach(searchResults, id: \.self) { currencyPairsSupported in
                            Button(action: {
                                self.currencyPair = currencyPairsSupported
                                showingCurrencySelector = false
                            }) {
                                CurrencyRow(currencyPairName: currencyPairsSupported)
                            }
                        }
                    } else {
                        ForEach(searchResults, id: \.self) { currencyPairsSupported in
                            Button(action: { select(currencyPairsSupported) }) {
                                CurrencyRow(currencyPairName: currencyPairsSupported, isLocked: false)
                            }
                        }
                    }
                }
                .id(UUID())
            }
            .navigationTitle("Currencies")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { showingCurrencySelector = false }) {
                        Text("Cancel")
                    }
                }
            }
        }
        .onAppear(perform: checkEntitlement)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
        .sheet(isPresented: $showingSubscriptionPaywall, onDismiss: checkEntitlement) {
            SubscriptionPaywall(showingSubscriptionPaywall: $showingSubscriptionPaywall)
        }
    }
    
    /*
     If user is subscribed:
     * Select currency and dismiss currency selector
     else:
     * Show subscription paywall
     */
    private func select(_ currencyPair: String) {
//        if currencyPair.isLocked {
//            showingSubscriptionPaywall = true
//        } else {
//            self.currencyPair = currencyPair.name
//            showingCurrencySelector = false
//        }
    }
    
    // Check if user subscription is active
    private func checkEntitlement() {
        #if SCREENSHOTS
        entitlementIsActive = true
        #else
        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            if purchaserInfo?.entitlements["all"]?.isActive == true {
                entitlementIsActive = true
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
extension View {
    func listStyle() -> some View {
        self.modifier(ListModifier())
    }
}


struct CurrencySelector_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelector(
            currencyPair: .constant("USD/GBP"),
            showingCurrencySelector: .constant(false)
        )
    }
}
