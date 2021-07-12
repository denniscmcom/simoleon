//
//  CurrencyConversion.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 12/07/2021.
//

import SwiftUI

struct CurrencyConversion: View {
    var currencyQuote: CurrencyQuoteModel
    let currencies: [String: CurrencyModel] = parseJson("Currencies.json")
    @State private var inputAmount: Float = 100
    
    var body: some View {
        VStack {
            let symbols = currencyQuote.symbol.split(separator: "/")
            // MARK: - First currency row
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .rectangleModifier(Color("Bone"), 80)
                
                RoundedRectangle(cornerRadius: 10)
                    .rectangleModifier(Color(.systemBackground), 80)
                    .overlay(
                        HStack {
                            SingleFlag(flag: currencies[String(symbols[0])]!.flag)
                            Text(String(symbols[0]))
                                .fontWeight(.semibold)
                                .padding(.leading)
                            
                            TextField("Amount", value: $inputAmount, formatter: NumberFormatter())
                                .padding(.leading)
                        }
                        .padding(.horizontal)
                    )
                    .offset(x: -10.0, y: -100.0)
                    .padding(.bottom, -100)
            }
            .padding(.leading, 10)
            .padding([.horizontal, .bottom])
            
            // MARK: - Second currency row
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .rectangleModifier(Color("Bone"), 80)

                RoundedRectangle(cornerRadius: 10)
                    .rectangleModifier(Color(.systemBackground), 80)
                    .overlay(
                        HStack {
                            SingleFlag(flag: currencies[String(symbols[1])]!.flag)
                            Text(String(symbols[1]))
                                .fontWeight(.semibold)
                                .padding(.leading)
                            
                            let conversion = inputAmount * currencyQuote.price
                            Text("\(conversion, specifier: "%.2f")")
                                .padding(.leading)
                            Spacer()
                        }
                        .padding(.horizontal)
                    )
                    .offset(x: -10.0, y: -100.0)
                    .padding(.bottom, -100)
            }
            .padding(.leading, 10)
            .padding(.horizontal)
        }
    }
}

struct CurrencyConversion_Previews: PreviewProvider {
    static var previews: some View {
        let currencyQuote: CurrencyQuoteModel = parseJson("CurrencyQuoteData.json")
        
        CurrencyConversion(currencyQuote: currencyQuote)
    }
}
