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
    @StateObject var currencyPair = CurrencyPair()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    CurrencySelector(currencyPair: currencyPair)
                    FavoriteButton(currencyPair: currencyPair)
                }
                
                ConversionBox(currencyPair: currencyPair)
                    .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Convert")
        .if(UIDevice.current.userInterfaceIdiom == .phone && showNavigationView ?? true) { content in
            NavigationView { content }
        }
    }
}


struct ConversionView_Previews: PreviewProvider {
    static var previews: some View {
        ConversionView(showNavigationView: true)
    }
}
