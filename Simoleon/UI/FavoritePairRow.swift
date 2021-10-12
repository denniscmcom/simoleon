//
//  FavoritePairRow.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 5/9/21.
//

import SwiftUI

struct FavoritePairRow: View {
    var favoritePair: FavoritePair
    let currencyDetails: [String: CurrencyModel] = try! readJson(from: "Currencies.json")
    
    var body: some View {
        HStack {
            let baseCurrencyDetails = currencyDetails[favoritePair.baseSymbol]
            let quoteCurrencyDetails = currencyDetails[favoritePair.quoteSymbol]
            
            Flag(flag: baseCurrencyDetails!.flag)
            Flag(flag: quoteCurrencyDetails!.flag)
                .offset(x: -25)
                .padding(.trailing, -25)
            
            Group {
                Text("From \(baseCurrencyDetails!.symbol)")
                Text("to \(quoteCurrencyDetails!.symbol)")
            }
            .font(.headline)
        }
    }
}

struct FavoritePairRow_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePairRow(favoritePair: FavoritePair())
    }
}
