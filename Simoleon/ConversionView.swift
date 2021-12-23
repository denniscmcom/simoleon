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
    @State var baseCurrency: SupportedCurrencyResult
    @State var quoteCurrency: SupportedCurrencyResult
    @State private var showingCurrencyList = false
    @State private var selecting: Selection = .baseCurrency
    
    // CurrencyTextfield variables
    @State private var amount = "1"
    
    // CurrencyConversion variables
    @State private var showConversion = false
    @State private var latestRate = CurrencyLatestRateResponse(message: [CurrencyLatestRateResult]())
    
    // Update currency rates
    @State private var timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
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
                    FavoriteButton(baseCurrency: $baseCurrency, quoteCurrency: $quoteCurrency)
                    
                }
                .padding(.bottom)
                
                // MARK: - Conversion box
                Text("\(baseCurrency.code) - \(baseCurrency.name)")
                    .font(.callout)
                    .fontWeight(.semibold)
                
                CurrencyTextfield(currencyCode: baseCurrency.code, amount: $amount)
                
                Divider()
                Text("\(quoteCurrency.code) - \(quoteCurrency.name)")
                    .font(.callout)
                    .fontWeight(.semibold)
                
                CurrencyConversion(
                    latestRate: latestRate,
                    currencyCode: quoteCurrency.code,
                    amount: $amount
                )
            }
            .padding(.horizontal)
            .sheet(isPresented: $showingCurrencyList) {
                CurrencyList(baseCurrency: $baseCurrency, quoteCurrency: $quoteCurrency, selecting: selecting)
            }
        }
        .onAppear {
            getConversion()
            timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
        }
        .onReceive(timer) { _ in
            getConversion()
        }
        .onDisappear {
            timer.upstream.connect().cancel()
        }
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
        let currencyPair = "\(baseCurrency.code)\(quoteCurrency.code)"
        let url = "https://api.simoleon.app/fx/latest?symbols=\(currencyPair)"
        httpRequest(url: url, model: CurrencyLatestRateResponse.self) { response in
            latestRate = response
            if latestRate.message.isEmpty {
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
        ConversionView(
            baseCurrency: SupportedCurrencyResult(code: "EUR", name: "Euro", isCrypto: 0),
            quoteCurrency: SupportedCurrencyResult(code: "USD", name: "U.S. Dollar", isCrypto: 0)
        )
    }
}
