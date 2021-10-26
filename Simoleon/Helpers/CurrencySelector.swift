//
//  CurrencySelector.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 26/10/21.
//

import SwiftUI

struct CurrencySelector: View {
    @State private var showCurrencyList = false
    @State private var selectedBaseCurrency = CurrencyModel(name: "US Dollar", code: "USD")
    @State private var selectedQuoteCurrency = CurrencyModel(name: "Euro", code: "EUR")
    
    var body: some View {
        HStack {
            Button(action: { showCurrencyList = true }) {
                CurrencySelectorButton(selectedCurrency: selectedBaseCurrency)
                CurrencySelectorButton(selectedCurrency: selectedQuoteCurrency)
            }
        }
    }
}

struct CurrencySelector_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelector()
    }
}
