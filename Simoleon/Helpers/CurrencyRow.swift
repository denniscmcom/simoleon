//
//  CurrencyRow.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 20/12/21.
//

import SwiftUI

struct CurrencyRow: View {
    var currency: SupportedCurrencyResult
    
    var body: some View {
        HStack {
            let flagName = getFlagName(currency: currency)
            Flag(flagName: flagName)
            
            VStack(alignment: .leading) {
                Text(currency.code)
                    .font(.headline)
                
                Text(currency.name)
                    .font(.callout)
                    .opacity(0.6)
            }
            .padding(.leading)
        }
    }
}

struct CurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRow(
            currency:
                SupportedCurrencyResult(code: "EUR", name: "Euro", isCrypto: 0)
        )
    }
}
