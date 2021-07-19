//
//  ConversionBox.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI

struct ConversionBox: View {
    @Binding var currencyPair: String
    @Binding var amountToConvert: String
    @Binding var price: Double
    @Binding var showingConversion: Bool
    @Binding var showingCurrencySelector: Bool
    @Binding var isEditing: Bool
    
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        VStack(alignment: .leading) {
            let currencies = currencyPair.split(separator: "/")
            Text("\(currencyMetadata[String(currencies[0])]!.name) (\(String(currencies[0])))")
                .font(.callout)
                .fontWeight(.semibold)
                .padding(.top, 40)
            
            ZStack(alignment: .trailing) {
                TextField("Enter amount", text: $amountToConvert) { startedEditing in
                if startedEditing {
                         withAnimation {
                            isEditing = true
                         }
                     }
                }
                onCommit: {
                     withAnimation {
                        isEditing = false
                     }
                 }
                .keyboardType(.decimalPad)
                .font(Font.title.weight(.semibold))
                .lineLimit(1)
                .padding(.bottom, 10)
            }
            
            Divider()
            
            Text("\(currencyMetadata[String(currencies[1])]!.name) (\(String(currencies[1])))")
                .font(.callout)
                .fontWeight(.semibold)
                .padding(.top, 10)
            
            if showingConversion {
                Text("\(makeConversion(), specifier: "%.2f")")
                    .font(Font.title.weight(.semibold))
                    .lineLimit(1)
                    .padding(.top, 5)
            } else {
                ProgressView()
                    .padding(.top, 5)
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
        ConversionBox(currencyPair: .constant("USD/GBP"), amountToConvert: .constant("1000"), price: .constant(1), showingConversion: .constant(false), showingCurrencySelector: .constant(false), isEditing: .constant(false))
    }
}
