//
//  CurrencyList.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 20/12/21.
//

import SwiftUI


struct CurrencyList: View {
    @Binding var baseCurrency: SupportedCurrencyResult
    @Binding var quoteCurrency: SupportedCurrencyResult
    var selecting: Selection
    
    var body: some View {
        NavigationView {
            List {
                let currencies = getCurrencies()
                ForEach(currencies, id: \.self) { currency in
                    Text(currency.code)
                }
            }
            .navigationTitle("Currencies")
        }
    }
    
    // MARK: - Get compatible currencies given currency code
    func getCurrencies() -> [SupportedCurrencyResult] {
        let pairs: SupportedPairResponse = readJson(from: "SupportedCurrencies.json")
        let currencies: SupportedCurrencyResponse = readJson(from: "SupportedCurrencies.json")
        var supportedCurrencies = [SupportedCurrencyResult]()
        
        if selecting == .baseCurrency {
            // Get base currencies compatible with quote currency
            let currencyPair = pairs.pairs.filter { $0.toCurrency == quoteCurrency.code }
            for currencyPair in currencyPair {
                let currency = currencies.currencies.filter { $0.code == currencyPair.fromCurrency }
                supportedCurrencies.append(contentsOf: currency)
            }
        } else {
            // Get quote currencies compatible with base currencies
            let currencyPair = pairs.pairs.filter { $0.fromCurrency == baseCurrency.code }
            for currencyPair in currencyPair {
                let currency = currencies.currencies.filter { $0.code == currencyPair.toCurrency }
                supportedCurrencies.append(contentsOf: currency)
            }
        }
        
        
        return supportedCurrencies
    }
}

struct CurrencyList_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyList(
            baseCurrency: .constant(SupportedCurrencyResult(code: "EUR", name: "Euro", isCrypto: 0)),
            quoteCurrency: .constant(SupportedCurrencyResult(code: "CHF", name: "Swiss Franc", isCrypto: 0)),
            selecting: .baseCurrency
        )
    }
}
