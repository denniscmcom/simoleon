//
//  ConversionView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 8/12/21.
//

import SwiftUI

struct ConversionView: View {
    var showNavigationView: Bool?
    
    // CurrencySelector variables
    @State private var baseCurrency = SupportedCurrencyResult(code: "EUR", name: "Euro", isCrypto: 0)
    @State private var quoteCurrency = SupportedCurrencyResult(code: "CHF", name: "Swiss Franc", isCrypto: 0)
    @State private var showingCurrencyList = false
    @State private var selecting: Selection = .baseCurrency
    
    // CurrencyTextfield variables
    @State private var amount = "1"
    
    // CurrencyConversion variables
    @State private var showConversion = false
    @State private var conversion = CurrencyConversionResponse(message: [CurrencyConversionResult]())
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                // MARK: - Currency selector
                HStack {
                    Button(action: { showCurrencyList(selecting: .baseCurrency) }) {
                       CurrencySelectorLabel(currency: baseCurrency)
                    }
                    
                    Button(action: { showCurrencyList(selecting: .quoteCurrency)}) {
                        CurrencySelectorLabel(currency: quoteCurrency)
                    }
                    
                    // MARK: - Favorite button
                    FavoriteButton()
                    
                }
                .padding(.bottom)
                
                // MARK: - Conversion box
                Text("\(baseCurrency.code) - \(baseCurrency.name)")
                    .font(.callout)
                    .fontWeight(.semibold)
                
                CurrencyTextfield(currencyCode: baseCurrency.code, amount: $amount)
                    .onChange(of: amount) { _ in
                        showConversion = false
                        getConversion()
                    }
                
                Divider()
                Text("\(quoteCurrency.code) - \(quoteCurrency.name)")
                    .font(.callout)
                    .fontWeight(.semibold)
                
                CurrencyConversion(
                    conversion: conversion,
                    currencyCode: quoteCurrency.code,
                    showConversion: $showConversion
                )
            }
            .padding()
            .sheet(isPresented: $showingCurrencyList) {
                CurrencyList(baseCurrency: $baseCurrency, quoteCurrency: $quoteCurrency, selecting: selecting)
            }
        }
        .onAppear(perform: getConversion)
        .navigationTitle("Convert")
        .if(UIDevice.current.userInterfaceIdiom == .phone && showNavigationView ?? true) { content in
            NavigationView { content }
        }
    }
    
    // Change selection and show CurrencyList()
    private func showCurrencyList(selecting: Selection) {
        self.selecting = selecting
        showingCurrencyList.toggle()
    }
    
    // Request conversion
    private func getConversion() {
        guard let amount = Float(amount) else {
            amount = ""
            showConversion = true
            return
        }
        
        let currencyPair = "\(baseCurrency.code)\(quoteCurrency.code)"
        let url = "https://api.simoleon.app/fx/convert?symbols=\(currencyPair)&amount=\(amount)"
        httpRequest(url: url, model: CurrencyConversionResponse.self) { response in
            conversion = response
            if conversion.message.isEmpty {
                // Handle exception
            } else {
                showConversion = true
            }
        }
    }
}

enum Selection {
    case baseCurrency, quoteCurrency
}

struct ConversionView_Previews: PreviewProvider {
    static var previews: some View {
        ConversionView(showNavigationView: true)
    }
}
