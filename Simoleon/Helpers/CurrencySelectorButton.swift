//
//  CurrencySelectorButton.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 26/10/21.
//

import SwiftUI

struct CurrencySelectorButton: View {
    var selectedCurrency: CurrencyModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color(.secondarySystemBackground))
            .frame(height: 60)
            .overlay(
                HStack {
                    Image(selectedCurrency.code)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    
                    Text(selectedCurrency.code)
                        .foregroundColor(.primary)
                        .font(.headline)
                }
            )
    }
}

struct CurrencySelectorButton_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelectorButton(
            selectedCurrency: CurrencyModel(name: "US Dollar", code: "USD")
        )
    }
}
