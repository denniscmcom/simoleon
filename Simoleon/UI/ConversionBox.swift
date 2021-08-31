//
//  ConversionBox.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI

struct ConversionBox: View {
    @ObservedObject var currencyConversion: CurrencyConversion
    @State private var amount = ""
    @State private var isEditing = false

    let networkHelper = NetworkHelper()
    let currencyDetails: [String: CurrencyModel] = try! readJson(from: "Currencies.json")
    
    var body: some View {
        VStack(alignment: .leading) {
            let baseCurrencyName = currencyDetails[currencyConversion.baseSymbol]!.name
            Text("\(baseCurrencyName) (\(currencyConversion.baseSymbol))")
                .font(.callout)
                .fontWeight(.semibold)
            
            ConversionTextfield(amount: $amount, isEditing: $isEditing)
            Divider()

            let quoteCurrencyName = currencyDetails[currencyConversion.quoteSymbol]!.name
            Text("\(quoteCurrencyName) (\(currencyConversion.quoteSymbol))")
                .font(.callout)
                .fontWeight(.semibold)
            
            if currencyConversion.isShowing {
                let conversion = convert()
                Text("\(conversion, specifier: "%.2f")")
                    .font(Font.title.weight(.semibold))
                    .lineLimit(1)
            } else {
                ProgressView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditing {
                    Button(action: {
                        UIApplication.shared.dismissKeyboard()
                        isEditing = false
                    }) {
                        Text("Done")
                    }
                }
            }
        }
    }
    
    private func convert() -> Double {
        guard let amount = Double(amount) else { return 0  }
        guard let price = currencyConversion.quote.price else { return 0 }

        return amount * price
    }
}

struct ConversionBox_Previews: PreviewProvider {
    static var previews: some View {
        ConversionBox(currencyConversion: CurrencyConversion())
    }
}
