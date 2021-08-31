//
//  CurrencyList.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 24/8/21.
//

import SwiftUI

struct CurrencyList: View {
    var currencies: [String]
    var selection: Selection
    @ObservedObject var currencyConversion: CurrencyConversion
    @State private var searchCurrency = ""
    
    @Environment(\.presentationMode) private var presentation
    let currencyDetails: [String: CurrencyModel] = try! readJson(from: "Currencies.json")
    
    var searchResults: [String] {
        if searchCurrency.isEmpty {
            return currencies.sorted()
        } else {
            return currencies.filter {$0.contains(searchCurrency.uppercased())}
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                SearchBar(placeholder: "Search...", text: $searchCurrency)
                    .padding(.vertical)
                    .accessibilityIdentifier("CurrencySearchBar")
                
                ForEach(searchResults, id: \.self) { symbol in
                    Button(action: {
                        if selection == .baseSymbol {
                            currencyConversion.baseSymbol = symbol
                        } else {
                            currencyConversion.quoteSymbol = symbol
                        }
                        
                        presentation.wrappedValue.dismiss()
                    }) {
                        let currency = currencyDetails[symbol]!
                        CurrencyRow(currency: currency)
                    }
                }
            }
            .listStyle()
            .navigationTitle("Currencies")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { presentation.wrappedValue.dismiss() }) {
                        Text("Cancel")
                    }
                }
            }
        }
    }
    
    enum Selection {
        case baseSymbol, quoteSymbol
    }
}
extension View {
    func listStyle() -> some View {
        self.modifier(ListModifier())
    }
}

struct CurrencyList_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyList(currencies: ["USD"], selection: .baseSymbol, currencyConversion: CurrencyConversion())
    }
}
