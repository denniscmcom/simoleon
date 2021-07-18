//
//  CurrencyButton.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI

struct CurrencyButton: View {
    @Binding var currency: String
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(Color(.secondarySystemBackground))
            .frame(height: 75)
            .overlay(
                HStack {
                    Image(currencyMetadata[currency]!.flag)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color(.systemGray), lineWidth: 1))
                    
                    Text("\(currency)")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("PlainButton"))
                }
            )
    }
}

struct CurrencyButton_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyButton(currency: .constant("USD"))
    }
}
