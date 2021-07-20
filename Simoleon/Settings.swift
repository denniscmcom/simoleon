//
//  Settings.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/07/2021.
//

import SwiftUI

struct Settings: View {
    let currencyPairs: [String] = parseJson("CurrencyPairs.json")
    @State private var selectedCurrencyPair = "USD/GBP"
    
    var body: some View {
        List {
            Section(header: Text("Preferences")) {
                Picker("Default currency", selection: $selectedCurrencyPair) {
                    ForEach(currencyPairs.sorted(), id: \.self) { currencyPair in
                        Text(currencyPair)
                    }
                }
            }
            
            Section(header: Text("Stay in touch")) {
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color(.systemRed))
                        .imageScale(.large)
                    
                    Text("Rate Simoleon")
                }
                
                Link(destination: URL(string: "https://dennistech.io")!) {
                    HStack {
                        Image("TwitterLogo")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        Text("Follow on Twitter")
                    }
                }
                
                Link(destination: URL(string: "https://dennistech.io/contact")!) {
                    HStack {
                        Image(systemName: "envelope.circle.fill")
                            .renderingMode(.original)
                            .imageScale(.large)
                        
                        Text("Contact")
                    }
                }
            }
            
            Section(header: Text("About")) {
                Link("Website", destination: URL(string: "https://dennistech.io")!)
                Link("Privacy Policy", destination: URL(string: "https://dennistech.io")!)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Settings")
        .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
            NavigationView { content }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
