//
//  SecondaryView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI

struct SecondaryView: View {
    var currencyQuote: CurrencyQuoteModel
    let currenciesMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    @State private var inputAmount: String = "100"
    
    var body: some View {
        if let symbol = currencyQuote.symbol {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    let symbols = symbol.split(separator: "/")
                    
                    // MARK: - First currency row
                    RoundedRectangle(cornerRadius: 10)
                        .rectangleModifier(Color(.systemBackground), 65)
                        .overlay(
                            HStack {
                                SingleFlag(flag: currenciesMetadata[String(symbols[0])]!.flag)
                                Text(String(symbols[0]))
                                    .fontWeight(.semibold)
                                    .padding(.leading)
                                
                                TextField("Amount", text: $inputAmount)
                                    .keyboardType(.decimalPad)
                                    .padding(.leading)
                            }
                            .padding(.horizontal)
                        )
                
                    // MARK: - Second currency row
                    RoundedRectangle(cornerRadius: 10)
                        .rectangleModifier(Color(.systemBackground), 65)
                        .overlay(
                            HStack {
                                SingleFlag(flag: currenciesMetadata[String(symbols[1])]!.flag)
                                Text(String(symbols[1]))
                                    .fontWeight(.semibold)
                                    .padding(.leading)
                                
                                Text("\(makeConversion(inputAmount), specifier: "%.2f")")
                                    .padding(.leading)
                                Spacer()
                            }
                            .padding(.horizontal)
                        )
                    
                }
                .padding()
            }
            .padding(.top)
            .navigationTitle("Conversion")
        }
    }
    
    /*
     Make currency conversion
     */
    private func makeConversion(_ inputAmount: String) -> Float {
        if inputAmount.isEmpty {  /// Avoid nil error when string is empty
            return 0
        } else {
            let conversion = Float(inputAmount)!  * currencyQuote.price!
            
            return conversion
        }
    }
}

struct SecondaryView_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryView(currencyQuote: CurrencyQuoteModel())
    }
}
