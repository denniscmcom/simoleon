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
    @Binding var amountIsEditing: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            let currencyDetails: [String: CurrencyDetailsModel] = try! read(json: "CurrencyDetails.json")
            let currencies = currencyPair.split(separator: "/")
            Text("\(currencyDetails[String(currencies[0])]!.name) (\(String(currencies[0])))")
                .font(.callout)
                .fontWeight(.semibold)
                .padding(.top, 40)
            
            ZStack(alignment: .trailing) {
                TextField("Enter amount", text: $amountToConvert) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            amountIsEditing = true
                        }
                    }
                }
                onCommit: {
                    withAnimation {
                        amountIsEditing = false
                    }
                }
                .keyboardType(.decimalPad)
                .font(Font.title.weight(.semibold))
                .lineLimit(1)
                .accessibilityIdentifier("ConversionTextField")
            }
            
            Divider()
            
            Text("\(currencyDetails[String(currencies[1])]!.name) (\(String(currencies[1])))")
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
    
    /*
     if the amount can be converted to Double:
     * Return amount
     else:
     * Return zero
     */
    func makeConversion() -> Double {
        if let amountToConvert = Double(amountToConvert) {
            return amountToConvert * price  // Conversion
        } else {
            return 0
        }
    }
}


struct ConversionBox_Previews: PreviewProvider {
    static var previews: some View {
        ConversionBox(
            currencyPair: .constant("USD/GBP"),
            amountToConvert: .constant("1000"),
            price: .constant(1),
            showingConversion: .constant(false),
            amountIsEditing: .constant(false)
        )
    }
}
