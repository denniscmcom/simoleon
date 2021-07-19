//
//  CurrencyRow.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI

struct CurrencyRow: View {
    var currencyPair: String
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        HStack {
            let currencies = currencyPair.split(separator: "/")
            Image(currencyMetadata[String(currencies[0])]!.flag)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(.systemGray), lineWidth: 1))
            
            Image(currencyMetadata[String(currencies[1])]!.flag)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(.systemGray), lineWidth: 1))
                .offset(x: -20)
                .padding(.trailing, -20)
            
            Text("From \(String(currencies[0])) to \(String(currencies[1]))")
                .fontWeight(.semibold)
                .foregroundColor(Color("PlainButton"))
                .padding(.leading)
            
            Spacer()
        }
    }
}

struct CurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRow(currencyPair: "USD/GBP")
    }
}
