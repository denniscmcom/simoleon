//
//  Conversion.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI
import Alamofire

struct Conversion: View {
    @State private var currencyPair = "USD/GBP"
    @State private var amountToConvert = "1000"
    @State private var price: Double = 1.00
    @State private var showingConversion = false
    @State private var showingCurrencySelector = false
    @State private var isEditing = false
    
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: { showingCurrencySelector = true }) {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color(.secondarySystemBackground))
                            .frame(height: 65)
                            .overlay(CurrencyRow(currencyPair: currencyPair).padding(.horizontal))
                    }
                    
                    FavouriteButton(currencyPair: currencyPair)
                }
                
                ConversionBox(
                    currencyPair: $currencyPair,
                    amountToConvert: $amountToConvert,
                    price: $price,
                    showingConversion: $showingConversion,
                    showingCurrencySelector: $showingCurrencySelector,
                    isEditing: $isEditing
                )
            }
            .padding()
            .onAppear { request(currencyPair) }
            .onChange(of: showingCurrencySelector, perform: { showingCurrencySelector in
                if !showingCurrencySelector {
                    request(currencyPair)
                }
            })
            .sheet(isPresented: $showingCurrencySelector) {
                CurrencySelector(currencyPair: $currencyPair, showingCurrencySelector: $showingCurrencySelector)
            }
        }
        .navigationTitle("Conversion")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                if isEditing {
                    Button("Cancel", action: {
                        UIApplication.shared.dismissKeyboard()
                        isEditing = false
                    })
                }
            }
        }
        .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
            NavigationView { content }
        }
    }
    
    private func request(_ currencyPair: String) {
        let url = "\(readConfig("API_URL")!)quotes?pairs=\(currencyPair)&api_key=\(readConfig("API_KEY")!)"
        
        Simoleon.request(url: url, model: [CurrencyQuoteModel].self) { response in
            self.showingConversion = false
            if let price = response.first?.price {
                self.price = price
                self.showingConversion =  true
            } else {
                // Handle error
            }
        }
    }
}


struct Conversion_Previews: PreviewProvider {
    static var previews: some View {
        Conversion()
    }
}
