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
    @StateObject var currencyConversion = CurrencyConversion()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    CurrencySelector(currencyConversion: currencyConversion)
                    FavoriteButton(currencyConversion: currencyConversion)
                }
                
                ConversionBox(currencyConversion: currencyConversion)
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
