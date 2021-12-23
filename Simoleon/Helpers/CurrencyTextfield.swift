//
//  CurrencyTextfield.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 21/12/21.
//

import SwiftUI

struct CurrencyTextfield: View {
    var currencyCode: String
    @Binding var amount: String
    
    var body: some View {
        TextField("Enter the amount", text: $amount)
            .keyboardType(.decimalPad)
            .font(.title2)
            .padding(15)
            .background(
                Color(.secondarySystemBackground)
                    .cornerRadius(15)
                    .frame(height: 55)
            )
    }
}

struct CurrencyTextfield_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyTextfield(currencyCode: "USD", amount: .constant("1"))
    }
}
