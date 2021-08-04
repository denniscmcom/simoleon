//
//  Conversion.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI
import Purchases

struct Conversion: View {
    var showNavigationView: Bool?
    
    @State var currencyPair: String
    @State private var amountToConvert = "1000"
    @State private var price: Double = 1.00
    @State private var showingConversion = false
    @State private var showingCurrencySelector = false
    @State private var amountIsEditing = false
    
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: { showingCurrencySelector = true }) {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color(.secondarySystemBackground))
                            .frame(height: 60)
                            .overlay(
                                CurrencyRow(currencyPairName: currencyPair)
                                    .padding(.horizontal)
                            )
                    }
                    
                    FavoriteButton(currencyPair: currencyPair)
                }
                
                ConversionBox(
                    currencyPair: $currencyPair,
                    amountToConvert: $amountToConvert,
                    price: $price,
                    showingConversion: $showingConversion,
                    amountIsEditing: $amountIsEditing
                )
            }
            .padding()
            .sheet(isPresented: $showingCurrencySelector, onDismiss: request) {
                CurrencySelector(currencyPair: $currencyPair, showingCurrencySelector: $showingCurrencySelector)
            }
        }
        .onAppear(perform: request)
        .navigationTitle("Convert")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if amountIsEditing {
                    Button(action: {
                        UIApplication.shared.dismissKeyboard()
                        amountIsEditing = false
                    }) {
                        Text("Cancel")
                    }
                }
            }
        }
        .if(UIDevice.current.userInterfaceIdiom == .phone && showNavigationView ?? true) { content in
            NavigationView { content }
        }
    }
    
    private func request() {
        showingConversion = false
        let url = "\(readConfig("API_URL")!)quotes?pairs=\(currencyPair)&api_key=\(readConfig("API_KEY")!)"
        networkRequest(url: url, model: [CurrencyQuoteModel].self) { response in
            if let price = response.first?.price {
                self.price = price
                showingConversion =  true
            } else {
                // Handle error
            }
        }
    }
}


struct Conversion_Previews: PreviewProvider {
    static var previews: some View {
        Conversion(currencyPair: "USD/GBP")
    }
}
