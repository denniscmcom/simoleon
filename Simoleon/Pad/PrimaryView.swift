//
//  PrimaryView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI

struct PrimaryView: View {
    @State var popularCurrencyPairsQuote: [CurrencyQuoteModel]
    
    var body: some View {
        List {
            NavigationLink(destination: SupplementaryView(popularCurrencyPairsQuote: $popularCurrencyPairsQuote)) {
                Text("Currencies")
            }
        }
        .listStyle(SidebarListStyle())
        .navigationBarTitle("Categories")
    }
}

struct PrimaryView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryView(popularCurrencyPairsQuote: [CurrencyQuoteModel()])
    }
}
