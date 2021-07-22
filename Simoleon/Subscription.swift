//
//  Subscription.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 22/07/2021.
//

import SwiftUI

struct Subscription: View {
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
                            
                            Text("Unlock all access", comment: "Headline in Subscription paywall")
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding(.top)
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    SubscriptionFeature(
                        symbol: "star.circle.fill",
                        title: "Favourite currencies",
                        text: "Save your favourite currencies to access them quickly.",
                        colour: Color(.systemYellow)
                    )
                    
                    SubscriptionFeature(
                        symbol: "flag.circle.fill",
                        title: "Over 170 currencies",
                        text: "Have access to almost every currency of the world.",
                        colour: Color(.systemRed)
                    )
                    
                    SubscriptionFeature(
                        symbol: "icloud.circle.fill",
                        title: "Simoleon on all your devices",
                        text: "Your settings and favourite currencies in all your devices.",
                        colour: Color(.systemBlue)
                    )
                    
                    SubscriptionFeature(
                        symbol: "bitcoinsign.circle.fill",
                        title: "Cryptos and commodities",
                        text: "Convert your currency between cryptos, gold, and silver.",
                        colour: Color(.systemOrange)
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
                        Text("Cancel", comment: "Button to dismiss paywall modal sheet")
                    }
                }
            }
        }
    }
}

struct Subscription_Previews: PreviewProvider {
    static var previews: some View {
        Subscription(showingSubscriptionPaywall: .constant(false))
    }
}
