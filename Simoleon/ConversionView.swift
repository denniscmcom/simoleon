//
//  ConversionView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI
import Purchases

struct ConversionView: View {
    var showNavigationView: Bool?
    @State var currencyPair: CurrencyPairModel
    
    // Conversion
    @State private var showingConversion = false
    @State private var amountIsEditing = false
    @State private var amountToConvert = ""
    @State private var price: Double = 0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack {
                    CurrencySelector(currencyPair: currencyPair)
                    FavoriteButton(currencyPair: currencyPair)
                }
            }
            .padding()
        }
        .onAppear(perform: createUrlAndRequest)
        .navigationTitle("Convert")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if amountIsEditing {
                    Button(action: {
                        UIApplication.shared.dismissKeyboard()
                        amountIsEditing = false
                    }) {
                        Text("Done")
                    }
                }
            }
        }
        .if(UIDevice.current.userInterfaceIdiom == .phone && showNavigationView ?? true) { content in
            NavigationView { content }
        }
    }
    
    private func createUrlAndRequest() {
        showingConversion = false
        let baseUrl = readConfigVariable(withKey: "API_URL")!
        let apiKey = readConfigVariable(withKey: "API_KEY")!
        let currencyPair = "\(currencyPair.baseSymbol)/\(currencyPair.quoteSymbol)"
        let url = "\(baseUrl)quotes?pairs=\(currencyPair)&api_key=\(apiKey)"
        
        httpRequest(url: url, model: [CurrencyQuoteModel].self) { response in
            if let price = response.first?.price {
                self.price = price
                showingConversion =  true
            }
        }
    }
}


struct ConversionView_Previews: PreviewProvider {
    static var previews: some View {
        ConversionView(showNavigationView: true, currencyPair: CurrencyPairModel(baseSymbol: "USD", quoteSymbol: "EUR"))
    }
}
