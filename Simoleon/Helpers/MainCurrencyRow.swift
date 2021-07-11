//
//  MainCurrencyRow.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 11/07/2021.
//

import SwiftUI

struct MainCurrencyRow: View {
    var currencyQuote: CurrencyQuoteModel
    let currencies: [String: CurrencyModel] = parseJson("Currencies.json")
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color("Border"), lineWidth: 2)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Bone")))
                .offset(x: 10, y: 10.0)
            
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color("Border"), lineWidth: 2)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color(.systemBackground)))
                .overlay(
                    VStack {
                        HStack {
                            let currencySymbols = currencyQuote.symbol.components(separatedBy: "/")
                            let mainSymbol = currencySymbols[0]
                            let secondarySymbol = currencySymbols[1]
                            let mainCurrencyFlag = currencies[mainSymbol]!.flag
                            let secondaryCurrencyFlag = currencies[secondarySymbol]!.flag
                            FlagsPair(mainCurrencyFlag: mainCurrencyFlag, secondaryCurrencyFlag: secondaryCurrencyFlag)
                                .frame(width: 80, height: 80)
                            
                            VStack(alignment: .leading) {
                                Text("Bid")
                                Text("\(currencyQuote.bid, specifier: "%.4f")")
                                    .fontWeight(.semibold)
                            }
                            .padding(.leading, 55)
                            
                            VStack(alignment: .leading) {
                                Text("Ask")
                                Text("\(currencyQuote.ask, specifier: "%.4f")")
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal)
                        }
                    }
                )
        }
        .frame(height: 250)
        .padding(.horizontal)
    }
}

struct MainCurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        let currencyQuote: CurrencyQuoteModel = parseJson("CurrencyQuoteData.json")
        
        MainCurrencyRow(currencyQuote: currencyQuote)
    }
}
