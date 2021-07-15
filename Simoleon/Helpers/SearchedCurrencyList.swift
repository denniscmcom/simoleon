//
//  SearchedCurrencyList.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 13/07/2021.
//

import SwiftUI
import Alamofire

struct SearchedCurrencyList: View {
    @Binding var text: String
    @State private var showingView = false
    @State private var searchedCurrencyPairsQuote = [CurrencyQuoteModel()]
    @State private var searchedSelectedCurrencyPairQuote: CurrencyQuoteModel? = nil
    
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        LazyVStack(spacing: 20) {
            if showingView {
                ForEach(searchedCurrencyPairsQuote, id: \.self) { currencyQuote in
                    CurrencyRow(currencyQuote: currencyQuote)
                        .onTapGesture { self.searchedSelectedCurrencyPairQuote = currencyQuote }
                }
            }
        }
        .onAppear(perform: requestCurrencyPairsQuote)
        .onChange(of: text, perform: { _ in
            requestCurrencyPairsQuote()
        })
        .sheet(item: self.$searchedSelectedCurrencyPairQuote) { currencyQuote in
            CurrencyConversion(currencyQuote: currencyQuote)
        }
    }
    
    /*
     Request API
     */
    private func requestCurrencyPairsQuote() {
        if !text.isEmpty {
            let searchedCurrencyPairsArray: [String] = parseJson("CurrencyPairs.json")
            let filteredSearchedCurrencyPairsArray = searchedCurrencyPairsArray.filter { $0.contains(text.uppercased()) }
            
            if filteredSearchedCurrencyPairsArray.count <= 327 {
                let searchedCurrencyPairsString = filteredSearchedCurrencyPairsArray.joined(separator: ",")
                let quotes = searchedCurrencyPairsString.replacingOccurrences(of: "/", with: "-")
                let url = "https://api.simoleon.app/quotes=\(quotes)"
            
                // Request popular currencies
                AF.request(url).responseDecodable(of: [CurrencyQuoteModel].self) { response in
                    if let searchedCurrencyPairsQuote = response.value {
                        self.searchedCurrencyPairsQuote = searchedCurrencyPairsQuote
                        self.showingView = true
                    } else {
                        // Handle error
                    }
                }
            }
        }
    }
}

struct SearchedCurrencyList_Previews: PreviewProvider {
    static var previews: some View {
        SearchedCurrencyList(text: .constant("USD/"))
    }
}
