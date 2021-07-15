//
//  CurrencyRow.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI

struct CurrencyRow: View {
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    var currency: String
    
    var body: some View {
        let currencies = currency.components(separatedBy: "/")
        let mainCurrency = String(currencies[0])
        let secondaryCurrency = String(currencies[1])
        HStack {
            Image(currencyMetadata[mainCurrency]!.flag)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(.systemGray), lineWidth: 1))
            
            Image(currencyMetadata[secondaryCurrency]!.flag)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(.systemGray), lineWidth: 1))
                .offset(x: -20)
                .padding(.trailing, -20)
            
            VStack(alignment: .leading) {
                Text("\(currency)")
                    .fontWeight(.semibold)
                
                Text("\(currencyMetadata[mainCurrency]!.name)/\(currencyMetadata[secondaryCurrency]!.name)")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .opacity(0.5)
                    .lineLimit(1)
            }
            .padding(.horizontal)
        }
    }
}

struct CurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRow(currency: "USD/GBP")
    }
}
