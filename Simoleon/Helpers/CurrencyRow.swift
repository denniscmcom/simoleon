//
//  CurrencyRow.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI

struct CurrencyRow: View {
    var currencyPairName: String
    var isLocked: Bool?
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        HStack {
            let currencies = currencyPairName.split(separator: "/")
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
            
            if isLocked ?? false {
                Image(systemName: "lock")
                    .foregroundColor(Color(.systemGray))
            }
        }
    }
}

struct CurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRow(currencyPairName: "USD/GBP")
    }
}
