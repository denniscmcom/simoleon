//
//  ConversionView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 8/12/21.
//

import SwiftUI

struct ConversionView: View {
    var showNavigationView: Bool?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    CurrencySelector()
                    // FavoriteButton
                }
                
                // ConversionBox
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
