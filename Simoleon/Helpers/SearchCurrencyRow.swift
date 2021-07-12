//
//  SearchCurrencyRow.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 12/07/2021.
//

import SwiftUI

struct SearchCurrencyRow: View {
    var currencyPair: String
    let currencies: [String: CurrencyModel] = parseJson("Currencies.json")
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .rectangleModifier(Color("Bone"), 100)
            
            RoundedRectangle(cornerRadius: 10)
                .rectangleModifier(Color(.systemBackground), 100)
                .overlay(
                    HStack {
                        let symbols = currencyPair.split(separator: "/")
                        let mainCurrencyFlag = currencies[String(symbols[0])]!.flag
                        let secondaryCurrencyFlag = currencies[String(symbols[1])]!.flag
                        
                        SmallFlagsPair(mainCurrencyFlag: mainCurrencyFlag, secondaryCurrencyFlag: secondaryCurrencyFlag)
                        
                        VStack(alignment: .leading) {
                            Text("\(currencyPair)")
                                .fontWeight(.semibold)
                            
                            Group {
                                Text("\(currencies[String(symbols[0])]!.name)")
                                Text("\(currencies[String(symbols[1])]!.name)")
                            }
                            .font(.callout)
                            .opacity(0.7)
                            .lineLimit(1)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                )
                .offset(x: -10.0, y: -120.0)
                .padding(.bottom, -120)
        }
        .padding(.leading, 10)
        .padding(.horizontal)
    }
}

struct SearchCurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchCurrencyRow(currencyPair: "USD/GBP")
    }
}
