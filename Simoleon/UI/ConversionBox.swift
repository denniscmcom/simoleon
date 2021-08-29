//
//  ConversionBox.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI

struct ConversionBox: View {
    @ObservedObject var currencyPair: CurrencyPair
    @State private var amount = ""
    @State private var isEditing = false
    @State private var showingConversion = false
    @State private var currencyQuote = CurrencyQuoteModel()
    @State private var showingAlert = false
    
    let networkHelper = NetworkHelper()
    let currencyDetails: [String: CurrencyModel] = try! readJson(from: "Currencies.json")
    
    var body: some View {
        VStack(alignment: .leading) {
            let baseCurrencyName = currencyDetails[currencyPair.baseSymbol]!.name
            Text("\(baseCurrencyName) (\(currencyPair.baseSymbol))")
                .font(.callout)
                .fontWeight(.semibold)
            
            ConversionTextfield(amount: $amount, isEditing: $isEditing)
            Divider()
            
            let quoteCurrencyName = currencyDetails[currencyPair.quoteSymbol]!.name
            Text("\(quoteCurrencyName) (\(currencyPair.quoteSymbol))")
                .font(.callout)
                .fontWeight(.semibold)
            
            if showingConversion {
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
        
        .onAppear {
            showingConversion = false
            let pair = "\(currencyPair.baseSymbol)/\(currencyPair.quoteSymbol)"
            let apiKey = readConfig(withKey: "API_KEY")!
            let url = "https://api.1forge.com/quotes?pairs=\(pair)&api_key=\(apiKey)"
            try? networkHelper.httpRequest(url: url, model: [CurrencyQuoteModel].self) { response in
                if let currencyQuote = response.first {
                    self.currencyQuote = currencyQuote
                } else {
                    showingAlert = true
                }
                
                showingConversion = true
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Currencies not supported."),
                message: Text("Currently, we are unable to convert from \(currencyPair.baseSymbol) to \(currencyPair.quoteSymbol)."),
                dismissButton: .default(Text("Dismiss")
                )
            )
        }
    }
    
    private func convert() -> Double {
        guard let amount = Double(amount) else { return 0  }
        guard let price = currencyQuote.price else { return 0 }
        
        return amount * price
    }
}

struct ConversionBox_Previews: PreviewProvider {
    static var previews: some View {
        ConversionBox(currencyPair: CurrencyPair())
    }
}
