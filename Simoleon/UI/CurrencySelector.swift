//
//  CurrencySelector.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 27/8/21.
//

import SwiftUI

struct CurrencySelector: View {
    @State var currencyPair: CurrencyPairModel
    @State private var showingList = false
    @State private var modalSelection: ModalType = .allCurrencies
    let currencyPairsSupported: [String] = try! read(json: "CurrencyPairsSupported.json")
    
    private enum ModalType {
        case allCurrencies, compatibleCurrencies
    }
    
    var body: some View {
        HStack {
            Button(action: {
                modalSelection = .allCurrencies
                showingList = true
            }) {
                CurrencyButton(selectedCurrency: currencyPair.baseSymbol)
            }
            
            Button(action: {
                modalSelection = .compatibleCurrencies
                showingList = true
            }) {
                CurrencyButton(selectedCurrency: currencyPair.quoteSymbol)
            }
        }
        .onChange(of: currencyPair.baseSymbol) { _ in
            // If the previous quote symbol is not compatible anymore with base symbol
            // return the first symbol of the new compatible symbols list
            let compatibleCurrencies = get(currencyType: .compatible(with: currencyPair.baseSymbol), from: currencyPairsSupported)
            if !compatibleCurrencies.contains(currencyPair.quoteSymbol) {
                currencyPair.quoteSymbol = compatibleCurrencies.sorted().first!
            }
        }
        .sheet(isPresented: $showingList) {
            if modalSelection == .allCurrencies {
                let currencies = get(currencyType: .all, from: currencyPairsSupported)
                CurrencyList(currencies: currencies, selectedCurrency: $currencyPair.baseSymbol)
            } else {
                let currencies = get(currencyType: .compatible(with: currencyPair.baseSymbol), from: currencyPairsSupported)
                CurrencyList(currencies: currencies, selectedCurrency: $currencyPair.quoteSymbol)
            }
        }
    }
    
    enum CurrencyType {
        case all
        case compatible(with: String)
    }
    
    func get(currencyType: CurrencyType, from currencyPairsSupported: [String]) -> [String] {
        var currencies = Set<String>()
        
        switch currencyType {
        case .all:
            for currencyPairSupported in currencyPairsSupported {
                let currency = currencyPairSupported.components(separatedBy: "/")[0]
                currencies.insert(currency)
            }
            
            return Array(currencies)
            
        case .compatible(with: let symbol):
            for currencyPairSupported in currencyPairsSupported {
                if currencyPairSupported.hasPrefix(symbol) {
                    let compatibleCurrency = currencyPairSupported.components(separatedBy: "/")[1]
                    currencies.insert(compatibleCurrency)
                }
            }
            
            return Array(currencies)
        }
    }
}

struct CurrencySelector_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelector(currencyPair: CurrencyPairModel(baseSymbol: "USD", quoteSymbol: "EUR"))
    }
}
