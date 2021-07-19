//
//  CurrencySelector.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI

struct CurrencySelector: View {
    @Binding var currencyPair: String
    @Binding var showingCurrencySelector: Bool
    @State private var searchCurrency = ""
    @State private var searching = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Search ...", text: $searchCurrency) { startedEditing in
                if startedEditing {
                         withAnimation {
                             searching = true
                         }
                     }
                } onCommit: {
                    withAnimation {
                        searching = false
                    }
                }
                
                Section(header: Text("All currencies")) {
                    ForEach(currencyPairs(), id: \.self) { currencyPair in
                        Button(action: {
                            self.currencyPair = currencyPair
                            showingCurrencySelector = false
                        }) {
                            CurrencyRow(currencyPair: currencyPair)
                        }
                    }
                }
            }
            .gesture(DragGesture()
                 .onChanged({ _ in
                     UIApplication.shared.dismissKeyboard()
                 })
             )
            .navigationTitle("Currencies")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK", action: { showingCurrencySelector = false })
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    if searching {
                         Button("Cancel") {
                            searchCurrency = ""
                             withAnimation {
                                searching = false
                                UIApplication.shared.dismissKeyboard()
                             }
                         }
                     }
                }
            }
        }
    }
    
    private func currencyPairs() -> [String] {
        let currencyPairs: [String] = parseJson("CurrencyPairs.json")
        
        if searchCurrency.isEmpty {
            return currencyPairs
        } else {
            return currencyPairs.filter { $0.contains(searchCurrency.uppercased()) }
        }
    }
}


struct CurrencySelector_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelector(currencyPair: .constant("USD/GBP"), showingCurrencySelector: .constant(false))
    }
}
