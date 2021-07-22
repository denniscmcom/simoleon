//
//  SubscriptionFeature.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 22/07/2021.
//

import SwiftUI

struct SubscriptionFeature: View {
    var symbol: String
    var title: LocalizedStringKey
    var text: LocalizedStringKey
    var colour: Color
    
    var body: some View {
        HStack(alignment:.top) {
            Image(systemName: symbol)
                .foregroundColor(colour)
                .font(.title)
            
            VStack(alignment: .leading) {
                Text(title, comment: "Title of subscription feature")
                    .font(.headline)
                
                Text(text, comment: "Description of subscription feature")
            }
        }
    }
}

struct SubscriptionFeature_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionFeature(
            symbol: "star.circle.fill",
            title: "Favourite currencies",
            text: "Save your favourite currencies to access them quickly.",
            colour: Color(.systemYellow)
        )
    }
}
