//
//  Settings.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/07/2021.
//

import SwiftUI

struct Settings: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var userSettings: FetchedResults<UserSettings>
    @State private var selectedCurrencyPair = "USD/GBP"
    let currencyPairs: [String] = parseJson("CurrencyPairs.json")
    
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
                Link(destination: URL(string: "https://itunes.apple.com/app/id1576390953?action=write-review")!) {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color(.systemRed))
                            .imageScale(.large)
                        
                        Text("Rate Simoleon")
                    }
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
                Link("Developer's Twitter", destination: URL(string: "https://twitter.com/dennisconcep")!)
            }
        }
        .onChange(of: selectedCurrencyPair, perform: { selectedCurrencyPair in
            setDefaultCurrency()
        })
        .onAppear(perform: fetchUserSettings)
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Settings")
        .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
            NavigationView { content }
        }
    }
    
    /*
     1) Fetch default currency from User Settings
     2) Change State var currencyPair
     */
    private func fetchUserSettings() {
        if let userSettings = userSettings.first {
            self.selectedCurrencyPair = userSettings.defaultCurrency ?? "USD/GBP"
        }
    }
    
    private func setDefaultCurrency() {
        if self.userSettings.isEmpty {  /// If it's empty -> add record
            let userSettings = UserSettings(context: viewContext)
            userSettings.defaultCurrency = selectedCurrencyPair
            
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        } else {  /// If not, update record
            self.userSettings.first?.defaultCurrency = selectedCurrencyPair
            try? viewContext.save()
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
