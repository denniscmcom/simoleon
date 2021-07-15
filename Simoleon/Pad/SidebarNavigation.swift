//
//  SidebarNavigation.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI

struct SidebarNavigation: View {
    @State var popularCurrencyPairsQuote = [CurrencyQuoteModel()]
    
    var body: some View {
        NavigationView {
            PrimaryView(popularCurrencyPairsQuote: popularCurrencyPairsQuote)
            SupplementaryView(popularCurrencyPairsQuote: $popularCurrencyPairsQuote)
            SecondaryView(currencyQuote: popularCurrencyPairsQuote[0])
        }
    }
}

struct SidebarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        SidebarNavigation()
    }
}
