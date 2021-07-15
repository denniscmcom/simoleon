//
//  SupplementaryView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI
import Alamofire

struct SupplementaryView: View {
    @Binding var popularCurrencyPairsQuote: [CurrencyQuoteModel]
    
    @State private var showingView = false
    @State private var text = ""
    @State private var isEditing = false
    
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        if showingView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    SearchBar(text: $text, isEditing: $isEditing)
                        .padding(.top)
                    
                    if text.isEmpty {
                        ForEach(popularCurrencyPairsQuote, id: \.self) { currencyQuote in
                            NavigationLink(destination: SecondaryView(currencyQuote: currencyQuote)) {
                                CurrencyRow(currencyQuote: currencyQuote)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    } else {
                        SearchedCurrencyList(text: $text)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Currencies")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    if isEditing {
                        Button("Cancel", action: {
                            text = ""
                            isEditing = false
                            UIApplication.shared.dismissKeyboard()
                        })
                    }
                }
            }
        } else {
            ProgressView()
                .onAppear(perform: requestCurrencyPairsQuote)
        }
    }
    
    /*
     Request API
     */
    private func requestCurrencyPairsQuote() {
        let popularCurrencyPairsArray: [String] = parseJson("PopularCurrencyPairs.json")
        let popularCurrencyPairsString = popularCurrencyPairsArray.joined(separator: ",")
        let quotes = popularCurrencyPairsString.replacingOccurrences(of: "/", with: "-")
        let url = "https://api.simoleon.app/quotes=\(quotes)"
        
        // Request popular currencies
        AF.request(url).responseDecodable(of: [CurrencyQuoteModel].self) { response in
            if let currencyPairsQuote = response.value {
                self.popularCurrencyPairsQuote = currencyPairsQuote
                self.showingView = true
            } else {
                // Handle error
            }
        }
    }
}


struct SupplementaryView_Previews: PreviewProvider {
    static var previews: some View {
        SupplementaryView(popularCurrencyPairsQuote: .constant([CurrencyQuoteModel()]))
    }
}
