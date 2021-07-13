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
    @State private var popularCurrencyPairs = [CurrencyQuoteModel()]
    @State private var selectedCurrencyQuote: CurrencyQuoteModel? = nil
    let currencyMetadata: [String: CurrencyMetadataModel] = parseJson("CurrencyMetadata.json")
    
    var body: some View {
        if showingView {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        SearchBar(text: $text, isEditing: $isEditing)
                            .padding(.vertical)
                        
                        ForEach(popularCurrencyPairs, id: \.self) { currencyQuote in
                            CurrencyRow(currencyQuote: currencyQuote)
                                .onTapGesture { self.selectedCurrencyQuote = currencyQuote }
                                .padding(.bottom)
                        }
                    }
                    .sheet(item: self.$selectedCurrencyQuote) { currencyQuote in
                        CurrencyConversion(currencyQuote: currencyQuote)
                    }
                }
                .navigationTitle("Simoleon")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {  }) {
                            Image(systemName: "gearshape")
                        }
                    }
                    
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
                .onAppear(perform: requestPopularCurrencies)
        }
    }
    
    /*
     Request API popular currency pairs
     */
    private func requestPopularCurrencies() {
        let popularCurrencyPairsArray: [String] = parseJson("PopularCurrencyPairs.json")
        let popularCurrencyPairsString = popularCurrencyPairsArray.joined(separator: ",")
        let quotes = popularCurrencyPairsString.replacingOccurrences(of: "/", with: "-")
        let url = "https://api.simoleon.app/quotes=\(quotes)"
        
        // Request popular currencies
        AF.request(url).responseDecodable(of: [CurrencyQuoteModel].self) { response in
            if let popularCurrencyPairs = response.value {
                self.popularCurrencyPairs = popularCurrencyPairs
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
