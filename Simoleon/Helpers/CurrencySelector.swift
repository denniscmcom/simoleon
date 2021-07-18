//
//  CurrencySelector.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI

struct CurrencySelector: View {
    @Binding var mainCurrencySelected: String
    @Binding var secondaryCurrencySelected: String
    @Binding var showingCurrencySelector: Bool
    @Binding var selectingMainCurrency: Bool
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(generateCurrencyList(), id: \.self) { currency in
                    Button(action: { select(currency) }) {
                        CurrencyRow(currency: currency)
                    }
                }
            }
            .navigationTitle("Currencies")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK", action: { showingCurrencySelector = false })
                }
            }
        }
    }
    
    private func generateCurrencyList() -> [String] {
        let currencyPairs: [String] = parseJson("CurrencyPairs.json")
        var currencies: [String] = []
        
        for currencyPair in currencyPairs {
            let splittedCurrencies = currencyPair.split(separator: "/")
            let mainCurrency = String(splittedCurrencies[0])
            if !currencies.contains(mainCurrency) {
                currencies.append(mainCurrency)
            }
        }
        
        return currencies
    }
    
    private func select(_ currency: String) {
        if selectingMainCurrency {
            self.mainCurrencySelected = currency
        } else {
            self.secondaryCurrencySelected = currency
        }
        
        showingCurrencySelector = false
    }
}

struct CurrencySelector_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelector(mainCurrencySelected: .constant(""), secondaryCurrencySelected: .constant(""), showingCurrencySelector: .constant(false), selectingMainCurrency: .constant(true))
    }
}
