//
//  ContentView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI

struct ContentView: View {
    @State var searchText = ""
    @State var searching = false
    @State private var refreshView = 0
    let currencyPairs: [String] = parseJson("CurrencyPairs.json")
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText, searching: $searching)
            List(filterCurrencies(), id: \.self) { currency in
                NavigationLink(destination: CurrencyConversion(currency: currency)) {
                    CurrencyRow(currency: currency)
                }
            }
            .id(UUID())
            .listStyle(InsetListStyle())
            .gesture(DragGesture()
                .onChanged({ _ in
                     UIApplication.shared.dismissKeyboard()
                 })
            )
        }
        .navigationTitle(searching ? "Search" : "Popular currencies")
        .toolbar {
             if searching {
                 Button("Cancel") { searchText = ""
                     withAnimation {
                        searching = false
                        UIApplication.shared.dismissKeyboard()
                     }
                 }
             }
        }
    }
    
    private func filterCurrencies() -> [String] {
        if searchText.isEmpty {
            return currencyPairs
        } else {
            return currencyPairs.filter { $0.contains(searchText.uppercased()) }
        }
    }
}
extension UIApplication {
      func dismissKeyboard() {
          sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
  }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
