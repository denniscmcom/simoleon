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
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .rectangleModifier(Color("Bone"), 250)
            
            RoundedRectangle(cornerRadius: 10)
                .rectangleModifier(Color(.systemBackground), 250)
                .overlay(
                    VStack {
                        let symbols = currencyQuote.symbol.split(separator: "/")
                        let mainCurrencyFlag = currencies[String(symbols[0])]!.flag
                        let SecondaryCurrencyFlag = currencies[String(symbols[1])]!.flag
                        HStack {
                        BigFlagsPair(mainCurrencyFlag: mainCurrencyFlag, secondaryCurrencyFlag: SecondaryCurrencyFlag)
                            
                            VStack(alignment: .leading) {
                                Text("Bid")
                                    .font(.title3)
                                
                                Text("\(currencyQuote.bid, specifier: "%.4f")")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal)
                            
                            VStack(alignment: .leading) {
                                Text("Ask")
                                    .font(.title3)
                                
                                Text("\(currencyQuote.ask, specifier: "%.4f")")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            .padding(.trailing)
                        }
                        
                        Text("100 \(String(symbols[0])) is worth \(currencyQuote.ask*100, specifier: "%.2f") \(String(symbols[1]))")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                    }
                )
                .offset(x: -10, y: -270)
                .padding(.bottom, -270)
        }
        .padding(.leading, 10)
        .padding(.horizontal)
    }
}
extension RoundedRectangle {
    func rectangleModifier(_ colour: Color, _ height: CGFloat) -> some View {
        self
            .strokeBorder(Color("Border"), lineWidth: 2)
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(colour))
            .frame(height: height)
            
    }
}

struct MainCurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        let currencyQuote: CurrencyQuoteModel = parseJson("CurrencyQuoteData.json")
        
        MainCurrencyRow(currencyQuote: currencyQuote)
    }
}
