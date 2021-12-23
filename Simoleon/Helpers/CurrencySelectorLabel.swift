//
//  CurrencySelectorLabel.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 20/12/21.
//

import SwiftUI

struct CurrencySelectorLabel: View {
    var currency: SupportedCurrencyResult
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color(.secondarySystemBackground))
            .frame(height: 60)
            .overlay(
                HStack {
                    Flag(currencyCode: currency.code)
                    Text(currency.code)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.leading, 5)
                }
            )
    }
}

struct CurrencySelectorLabel_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelectorLabel(
            currency: SupportedCurrencyResult(code: "EUR", name: "Euro", isCrypto: 0)
        )
    }
}
