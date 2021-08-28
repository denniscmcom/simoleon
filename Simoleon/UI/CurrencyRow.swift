//
//  CurrencyRow.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI

struct CurrencyRow: View {
    var currency: CurrencyModel
    
    var body: some View {
        HStack {
            Flag(flag: currency.flag)
            VStack(alignment: .leading) {
                Text(currency.symbol)
                    .font(.headline)
                
                Text(currency.name)
                    .font(.subheadline)
                    .lineLimit(1)
            }
            .padding(.horizontal)
        }
    }
}

struct CurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRow(
            currency:
                CurrencyModel(
                    symbol: "USD",
                    name: "United States Dollar",
                    flag: "US",
                    isCrypto: false
                )
        )
    }
}
