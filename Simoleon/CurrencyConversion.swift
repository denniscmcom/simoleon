//
//  CurrencyConversion.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 12/07/2021.
//

import SwiftUI

struct CurrencyConversion: View {
    var currencyQuote: CurrencyQuoteModel
    let currenciesMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    @State private var inputAmount: String = "100"
    @Environment(\.presentationMode) private var currencyConversionPresentation
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    let symbols = currencyQuote.symbol!.split(separator: "/")
                    // MARK: - First currency row
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .rectangleModifier(Color("Shadow"), 80)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .rectangleModifier(Color(.systemBackground), 80)
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
                            .offset(x: -10.0, y: -100.0)
                            .padding(.bottom, -100)
                    }
                    .padding(.leading, 10)
                    .padding([.horizontal, .bottom])
                    
                    // MARK: - Second currency row
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .rectangleModifier(Color("Shadow"), 80)

                        RoundedRectangle(cornerRadius: 10)
                            .rectangleModifier(Color(.systemBackground), 80)
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
                            .offset(x: -10.0, y: -100.0)
                            .padding(.bottom, -100)
                    }
                    .padding(.leading, 10)
                    .padding(.horizontal)
                    
                }
                .padding(.vertical)
            }
            .navigationTitle("Conversion")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: { currencyConversionPresentation.wrappedValue.dismiss() })
                }
            }
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

struct CurrencyConversion_Previews: PreviewProvider {
    static var previews: some View {
        let currencyQuote: CurrencyQuoteModel = parseJson("CurrencyQuoteData.json")
        
        CurrencyConversion(currencyQuote: currencyQuote)
    }
}
