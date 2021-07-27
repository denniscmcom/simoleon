//
//  SubscriptionPaywall.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 22/07/2021.
//

import SwiftUI

struct SubscriptionPaywall: View {
    @Binding var showingSubscriptionPaywall: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Spacer()
                        VStack {
                            Image("Subscription")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .cornerRadius(25)
                            
                            Text("Unlock All Access")
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding(.top)
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    SubscriptionFeature(
                        symbol: "star.circle.fill",
                        colour: Color(.systemYellow),
                        title: "Favorite Forex Pairs",
                        description: "Save any currency pair for quick access."
                    )
                    
                    SubscriptionFeature(
                        symbol: "flag.circle.fill",
                        colour: Color(.systemRed),
                        title: "Over 170 Currencies",
                        description: "Access almost every currency of the world."
                    )
                    
                    SubscriptionFeature(
                        symbol: "icloud.circle.fill",
                        colour: Color(.systemBlue),
                        title: "Everything is Up-to-date",
                        description: "Your settings and favorite currencies in all your devices."
                    )
                    
                    SubscriptionFeature(
                        symbol: "bitcoinsign.circle.fill",
                        colour: Color(.systemOrange),
                        title: "Cryptos and Commodities",
                        description: "Convert currency between cryptos, gold, and silver."
                    )
                    
                    Spacer()
                    SubscribeButton(showingSubscriptionPaywall: $showingSubscriptionPaywall)
                    HStack {
                        Spacer()
                        RestoreButton(showingSubscriptionPaywall: $showingSubscriptionPaywall)
                        Spacer()
                    }
                }
                .padding(.bottom)
                .padding(.horizontal, 40)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { showingSubscriptionPaywall = false }) {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

struct SubscriptionPaywall_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionPaywall(showingSubscriptionPaywall: .constant(false))
    }
}
