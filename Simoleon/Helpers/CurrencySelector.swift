//
//  CurrencySelector.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 8/12/21.
//

import SwiftUI

enum Selection {
    case baseCurrency, quoteCurrency
}

struct CurrencySelector: View {
    @State private var baseCurrency = SupportedCurrencyResult(code: "EUR", name: "Euro", isCrypto: 0)
    @State private var quoteCurrency = SupportedCurrencyResult(code: "CHF", name: "Swiss Franc", isCrypto: 0)
    @State private var showingCurrencyList = false
    @State private var selecting: Selection = .baseCurrency
    
    var body: some View {
        HStack {
            Button(action: {
                selecting = .baseCurrency
                showingCurrencyList.toggle()
                
            }) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(.secondarySystemBackground))
                    .frame(height: 60)
                    .overlay(
                        Text(baseCurrency.code)
                    )
            }
            
            Button(action: {
                selecting = .quoteCurrency
                showingCurrencyList.toggle()
            }) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(.secondarySystemBackground))
                    .frame(height: 60)
                    .overlay(
                        Text(quoteCurrency.code)
                    )
            }
        }
        .sheet(isPresented: $showingCurrencyList) {
            CurrencyList(baseCurrency: $baseCurrency, quoteCurrency: $quoteCurrency, selecting: selecting)
        }
    }
}

struct CurrencySelector_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelector()
    }
}
