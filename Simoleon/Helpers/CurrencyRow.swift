//
//  CurrencyRow.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI

struct CurrencyRow: View {
    var currency: String
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        HStack {
            Image(currencyMetadata[currency]!.flag)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(.systemGray), lineWidth: 1))
            
            VStack(alignment: .leading) {
                Text("\(currency)")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("PlainButton"))
                
                Text("\(currencyMetadata[currency]!.name)")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("PlainButton"))
                    .opacity(0.5)
                    .lineLimit(1)
            }
            .padding(.horizontal)
        }
    }
}

struct CurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRow(currency: "USD")
    }
}
