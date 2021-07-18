//
//  Conversion.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI
import Alamofire

struct Conversion: View {
    @State private var mainCurrency = "USD"
    @State private var secondaryCurrency = "GBP"
    @State private var amountToConvert = "1000"
    @State private var price: Double = 1.00
    @State private var showingConversion = false
    @State private var showingCurrencySelector = false
    @State private var selectingMainCurrency = false
    @State private var currencyPairNotFound = false
    
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: { selectingMainCurrency = true; showingCurrencySelector = true }) {
                        CurrencyButton(currency: $mainCurrency)
                    }
                    
                    Button(action: { selectingMainCurrency = false; showingCurrencySelector = true }) {
                        CurrencyButton(currency: $secondaryCurrency)
                    }
                }
                
                ConversionBox(
                    mainCurrency: $mainCurrency,
                    secondaryCurrency: $secondaryCurrency,
                    amountToConvert: $amountToConvert,
                    price: $price,
                    showingConversion: $showingConversion,
                    showingCurrencySelector: $showingCurrencySelector,
                    currencyPairNotFound: $currencyPairNotFound
                )
            }
            .padding()
            .onAppear { requestApi(mainCurrency, secondaryCurrency) }
            .onChange(of: showingCurrencySelector, perform: { showingCurrencySelector in
                if !showingCurrencySelector {
                    requestApi(mainCurrency, secondaryCurrency)
                }
            })
            .sheet(isPresented: $showingCurrencySelector) {
                CurrencySelector(
                    mainCurrencySelected: $mainCurrency,
                    secondaryCurrencySelected: $secondaryCurrency,
                    showingCurrencySelector: $showingCurrencySelector,
                    selectingMainCurrency: $selectingMainCurrency
                )
            }
        }
        .navigationBarHidden(true)
    }
    
    private func requestApi(_ mainCurrency: String, _ secondaryCurrency: String) {
        let url = "https://api.1forge.com/quotes?pairs=\(mainCurrency)/\(secondaryCurrency)&api_key=BFWeJQ3jJtqqpDv5ArNis59pAlFcQ4KF"
        
        AF.request(url).responseDecodable(of: [CurrencyQuoteModel].self) { response in
            self.showingConversion = false
            self.currencyPairNotFound = false
            
            if let currencyQuotes = response.value {
                if let price = currencyQuotes.first?.price {
                    self.price = price
                    self.showingConversion =  true
                } else {
                    self.currencyPairNotFound = true
                }
            } else {
//               Handle error
            }
        }
    }
}


struct Conversion_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Conversion()
        }
    }
}
