//
//  CurrencyRow.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 11/07/2021.
//

import SwiftUI

struct CurrencyRow: View {
    var currencyQuote: CurrencyQuoteModel
    let currenciesMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .rectangleModifier(Color("Shadow"), 80)
            
            RoundedRectangle(cornerRadius: 10)
                .rectangleModifier(Color(.systemBackground), 80)
                .overlay(
                    HStack {
                        let symbols = currencyQuote.symbol!.split(separator: "/")
                        let mainCurrencyFlag = currenciesMetadata[String(symbols[0])]!.flag
                        let secondaryCurrencyFlag = currenciesMetadata[String(symbols[1])]!.flag
                        
                        FlagPair(mainCurrencyFlag: mainCurrencyFlag, secondaryCurrencyFlag: secondaryCurrencyFlag)
                        
                        VStack(alignment: .leading) {
                            Text("\(String(symbols[0]))")
                                .fontWeight(.semibold)
                            
                            Text("\(String(symbols[1]))")
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading) {
                            Text("Bid")
                            let bid = currencyQuote.bid!
                            Text("\(bid, specifier: createSpecifier(bid))")
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                
                        }
                        .padding(.trailing)
                        
                        VStack(alignment: .leading) {
                            Text("Ask")
                            let ask = currencyQuote.ask!
                            Text("\(ask, specifier: createSpecifier(ask))")
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                )
                .offset(x: -6.0, y: -95.0)
                .padding(.bottom, -95)
        }
        .padding(.leading, 6)
        .padding(.horizontal)
    }
    
    /*
     Choose how many decimals depending on whether the price is hundreds, thousands, etc
     */
    
    private func createSpecifier(_ amount: Float) -> String {
        if amount >= 10 {
            return "%.2f"
        } else {
            return "%.4f"
        }
    }
    
    /*
     Convert unix time into human readable
     */
    private func convertUnixTime(_ timestamp: Int) -> String {
        let now = Date()
        let convertedDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        
        return formatter.string(from: convertedDate, to: now)!
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

struct CurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        let currencyQuote: CurrencyQuoteModel = parseJson("CurrencyQuoteData.json")
        
        CurrencyRow(currencyQuote: currencyQuote)
    }
}
