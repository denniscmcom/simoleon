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
    
    var currencyPairs: [CurrencyPairModel] = parseJson("CurrencyPairs.json")
    
    /*
     If searched currency string is empty:
     * Show all currencies
     else:
     * Show filtered list of currencies containing searched currency string
     */
    var searchResults: [CurrencyPairModel] {
        if searchCurrency.isEmpty {
            return currencyPairs.sorted { !$0.isLocked && $1.isLocked }
        } else {
            return currencyPairs.filter { $0.name.contains(searchCurrency.uppercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(placeholder: "Search...", text: $searchCurrency)
                    .padding()
                
                    List(searchResults, id: \.self) { currencyPair in
                        Button(action: { select(currencyPair.name) }) {
                            CurrencyRow(currencyPairName: currencyPair.name)
                        }
                    }
                .id(UUID())
                .listStyle(PlainListStyle())
                .gesture(DragGesture()
                            .onChanged({ _ in
                                UIApplication.shared.dismissKeyboard()
                            })
                )
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
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
        .sheet(isPresented: $showingSubscriptionPaywall) {
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
