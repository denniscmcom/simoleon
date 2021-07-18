//
//  ConversionBox.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI
import Introspect

struct ConversionBox: View {
    @Binding var mainCurrency: String
    @Binding var secondaryCurrency: String
    @Binding var amountToConvert: String
    @Binding var price: Double
    @Binding var showingConversion: Bool
    @Binding var showingCurrencySelector: Bool
    @Binding var currencyPairNotFound: Bool
    
    @State private var showingCancelationButton = false
    
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(currencyMetadata[mainCurrency]!.name) (\(mainCurrency))")
                .font(.callout)
                .fontWeight(.semibold)
                .padding(.top, 40)
            
            ZStack(alignment: .trailing) {
                TextField("Enter amount", text: $amountToConvert)
                    .keyboardType(.decimalPad)
                    .font(Font.title.weight(.semibold))
                    .lineLimit(1)
                    .padding(.bottom, 10)
                    .introspectTextField { textField in
                        if !showingCurrencySelector {
                            textField.becomeFirstResponder()
                        }
                    }
            }
            
            Divider()
            
            Text("\(currencyMetadata[secondaryCurrency]!.name) (\(secondaryCurrency))")
                .font(.callout)
                .fontWeight(.semibold)
                .padding(.top, 10)
            
            if showingConversion {
                Text("\(makeConversion(), specifier: "%.2f")")
                    .font(Font.title.weight(.semibold))
                    .lineLimit(1)
                    .padding(.top, 5)
            } else {
                if currencyPairNotFound {
                    Text("The currency pair selected is not supported yet 😢")
                        .padding(.top, 5)
                } else {
                    ProgressView()
                        .padding(.top, 5)
                }
            }
        }
    }
    
    
    private func makeConversion() -> Double {
        if amountToConvert.isEmpty {  /// Avoid nil error when string is empty
            return 0
        } else {
            let conversion = Double(amountToConvert)!  * price

            return conversion
        }
    }
}


struct ConversionBox_Previews: PreviewProvider {
    static var previews: some View {
        ConversionBox(mainCurrency: .constant("USD"), secondaryCurrency: .constant("GBP"), amountToConvert: .constant("1000"), price: .constant(1), showingConversion: .constant(true), showingCurrencySelector: .constant(false), currencyPairNotFound: .constant(false))
    }
}
