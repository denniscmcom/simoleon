//
//  ConversionBox.swift
//  SimoleonWatchOS Extension
//
//  Created by Dennis Concepción Martín on 27/07/2021.
//

import SwiftUI

struct ConversionBox: View {
    var currencyPair: String
    
    @State private var price: Double =  1
    @State private var showingConversion = false
    
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        VStack(alignment: .leading) {
            let currencies = currencyPair.split(separator: "/")
            Text("\(currencyMetadata[String(currencies[0])]!.name) (\(String(currencies[0])))")
                .font(.footnote)
            
            Text("\(1.00, specifier: "%.2f")")
                .font(.title2)
                .fontWeight(.semibold)
            
            Divider()
            
            Text("\(currencyMetadata[String(currencies[1])]!.name) (\(String(currencies[1])))")
                .font(.footnote)
            
            if showingConversion {
                Text("\(1 * price, specifier: "%.2f")")
                    .font(.title2)
                    .fontWeight(.semibold)
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: request)
    }
    
    private func request() {
        let url = "\(readConfig("API_URL")!)quotes?pairs=\(currencyPair)&api_key=\(readConfig("API_KEY")!)"
        
        SimoleonWatchOS_Extension.request(url: url, model: [CurrencyQuoteModel].self) { response in
            if let price = response.first?.price {
                self.price = price
                showingConversion =  true
            } else {
                // Handle error
            }
        }
    }
}

struct ConversionBox_Previews: PreviewProvider {
    static var previews: some View {
        ConversionBox(currencyPair: "USD/GBP")
    }
}
