//
//  ContentView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 08/07/2021.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State private var showingView = false
    @State private var text = ""
    @State private var isEditing = false
    @State private var popularCurrencyPairsQuote = [CurrencyQuoteModel()]
    @State private var popularSelectedCurrencyPairQuote: CurrencyQuoteModel? = nil
    
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        if showingView {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        SearchBar(text: $text, isEditing: $isEditing)
                            .padding(.vertical)
                            .padding(.top)
                        
                        if text.isEmpty {
                            ForEach(popularCurrencyPairsQuote, id: \.self) { currencyQuote in
                                CurrencyRow(currencyQuote: currencyQuote)
                                    .onTapGesture { self.popularSelectedCurrencyPairQuote = currencyQuote }
                                    .padding(.bottom)
                            }
                        } else {
                            SearchedCurrencyList(text: $text)
                        }
                    }
                    .sheet(item: self.$popularSelectedCurrencyPairQuote) { currencyQuote in
                        CurrencyConversion(currencyQuote: currencyQuote)
                    }
                }
                .navigationTitle("Simoleon")
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
/*
 Dismiss keyboard on cancel textfield
 */
extension UIApplication {
      func dismissKeyboard() {
          sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
  }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
