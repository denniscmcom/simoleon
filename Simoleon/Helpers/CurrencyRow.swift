//
//  CurrencyRow.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 11/07/2021.
//

import SwiftUI

struct CurrencyRow: View {
    var currencyQuote: CurrencyQuoteModel
    let currencies: [String: CurrencyModel] = parseJson("Currencies.json")
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .rectangleModifier(Color("Bone"), 100)
            
            RoundedRectangle(cornerRadius: 10)
                .rectangleModifier(Color(.systemBackground), 100)
                .overlay(
                    HStack {
                        let symbols = currencyQuote.symbol.split(separator: "/")
                        let mainCurrencyFlag = currencies[String(symbols[0])]!.flag
                        let SecondaryCurrencyFlag = currencies[String(symbols[1])]!.flag
                        
                        SmallFlagsPair(mainCurrencyFlag: mainCurrencyFlag, secondaryCurrencyFlag: SecondaryCurrencyFlag)
                        
                        VStack(alignment: .leading) {
                            Text("\(String(symbols[0]))")
                                .fontWeight(.semibold)
                            
                            Text("\(String(symbols[1]))")
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading) {
                            Text("Bid")
                            Text("\(currencyQuote.bid, specifier: "%.4f")")
                                .fontWeight(.semibold)
                                
                        }
                        .padding(.trailing)
                        
                        VStack(alignment: .leading) {
                            Text("Ask")
                            Text("\(currencyQuote.ask, specifier: "%.4f")")
                                .fontWeight(.semibold)
                                
                        }
                    }
                )
                .offset(x: -10.0, y: -120.0)
                .padding(.bottom, -120)
        }
        .padding(.leading, 10)
        .padding(.horizontal)
    }
}

struct CurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        let currencyQuote: CurrencyQuoteModel = parseJson("CurrencyQuoteData.json")
        
        CurrencyRow(currencyQuote: currencyQuote)
    }
}
