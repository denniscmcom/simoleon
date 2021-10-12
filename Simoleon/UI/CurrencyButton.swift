//
//  CurrencyButton.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 24/8/21.
//

import SwiftUI

struct CurrencyButton: View {
    var selectedCurrency: String
    let currencyDetails: [String: CurrencyModel] = try! readJson(from: "Currencies.json")
    
    var body: some View {
        let currency = currencyDetails[selectedCurrency]!
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color(.secondarySystemBackground))
            .frame(height: 60)
            .overlay(
                HStack {
                    Flag(flag: currency.flag)
                    Text(currency.symbol)
                        .foregroundColor(.primary)
                        .font(.headline)
                }
            )
    }
}

struct CurrencyButton_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyButton(selectedCurrency: "USD")
    }
}
