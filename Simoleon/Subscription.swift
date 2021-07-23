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
                    
                    HStack(alignment:.top) {
                        Image(systemName: "star.circle.fill")
                            .foregroundColor(Color(.systemYellow))
                            .font(.title)
                        
                        VStack(alignment: .leading) {
                            Text("Favourite currencies", comment: "Subscription feature title")
                                .font(.headline)
                            
                            Text("Save your favourite currencies to access them quickly.", comment: "Subscription feature description")
                        }
                    }
                    
                    HStack(alignment:.top) {
                        Image(systemName: "flag.circle.fill")
                            .foregroundColor(Color(.systemRed))
                            .font(.title)
                        
                        VStack(alignment: .leading) {
                            Text("Over 170 currencies", comment: "Subscription feature title")
                                .font(.headline)
                            
                            Text("Have access to almost every currency of the world.", comment: "Subscription feature description")
                        }
                    }
                    
                    HStack(alignment:.top) {
                        Image(systemName: "icloud.circle.fill")
                            .foregroundColor(Color(.systemBlue))
                            .font(.title)
                        
                        VStack(alignment: .leading) {
                            Text("Simoleon on all your devices", comment: "Subscription feature title")
                                .font(.headline)
                            
                            Text("Your settings and favourite currencies in all your devices.", comment: "Subscription feature description")
                        }
                    }
                    
                    HStack(alignment:.top) {
                        Image(systemName: "bitcoinsign.circle.fill")
                            .foregroundColor(Color(.systemOrange))
                            .font(.title)
                        
                        VStack(alignment: .leading) {
                            Text("Cryptos and commodities", comment: "Subscription feature title")
                                .font(.headline)
                            
                            Text("Convert your currency between cryptos, gold, and silver.", comment: "Subscription feature description")
                        }
                    }
                    
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
