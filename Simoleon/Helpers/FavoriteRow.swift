//
//  FavoriteRow.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 23/12/21.
//

import SwiftUI

struct FavoriteRow: View {
    var baseCurrency: String
    var quoteCurrency: String
    
    var body: some View {
        let baseCurrencyObject = getCurrencyObject(with: baseCurrency)
        let quoteCurrencyObject = getCurrencyObject(with: quoteCurrency)
        NavigationLink(destination:
            ConversionView(
                showNavigationView: false,
                baseCurrency: baseCurrencyObject,
                quoteCurrency: quoteCurrencyObject
            )
        ) {
            HStack {
                Flag(currencyCode: baseCurrency)
                Flag(currencyCode: quoteCurrency)
                    .offset(x: -25)
                    .padding(.trailing, -25)
                
                let pairObject = getPairObject()
                VStack(alignment: .leading) {
                    Text(pairObject.symbol)
                        .font(.headline)
                    
                    Text(pairObject.name)
                        .font(.callout)
                        .opacity(0.6)
                }
                .padding(.leading)
            }
        }
    }
    
    // Get pair object
    private func getPairObject() -> SupportedPairResult {
        let pairResponse: SupportedPairResponse = readJson(from: "SupportedCurrencies.json")
        let pair = pairResponse.pairs.filter { $0.fromCurrency == baseCurrency && $0.toCurrency == quoteCurrency }
        
        return pair.first!
    }
    
    // Get currency object
    private func getCurrencyObject(with currencyCode: String) -> SupportedCurrencyResult {
        let currencyResponse: SupportedCurrencyResponse = readJson(from: "SupportedCurrencies.json")
        let currency = currencyResponse.currencies.filter { $0.code == currencyCode }
        
        return currency.first!
    }
}

struct FavoriteRow_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteRow(baseCurrency: "EUR", quoteCurrency: "USD")
    }
}
