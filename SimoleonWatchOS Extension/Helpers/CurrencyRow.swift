//
//  CurrencyRow.swift
//  SimoleonWatchOS Extension
//
//  Created by Dennis Concepción Martín on 27/07/2021.
//

import SwiftUI

struct CurrencyRow: View {
    var currencyPair: String
    
    var body: some View {
        let currencies = currencyPair.split(separator: "/")
        Text("From \(String(currencies[0])) to \(String(currencies[1]))")
                .fontWeight(.semibold)
                .padding(.leading)
    }
}

struct CurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLink(destination: ConversionBox(currencyPair: "USD/GBP")
                        .navigationTitle("Convert")
        ) {
            CurrencyRow(currencyPair: "USD/GBP")
        }
    }
}
