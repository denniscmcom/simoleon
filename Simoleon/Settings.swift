//
//  Settings.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/07/2021.
//

import SwiftUI
import Purchases

struct Settings: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var defaultCurrency: FetchedResults<DefaultCurrency>
    
    @State private var selectedDefaultCurrency = ""
    @State private var showingSubscriptionPaywall = false
    @State private var entitlementIsActive = false
    
    let currencyPairs: [String] = parseJson("CurrencyPairs.json")
    
    var body: some View {
        List {
            Section(header: Text("Preferences", comment: "Section header in settings")) {
                if entitlementIsActive {
                    Picker(selection: $selectedDefaultCurrency, label: Text("Default currency", comment: "Picker to select default currency"), content: {
                        ForEach(currencyPairs.sorted(), id: \.self) { currencyPair in
                            Text(currencyPair)
                        }
                    })
                } else {
                    LockedCurrencyPicker()
                        .contentShape(Rectangle())
                        .onTapGesture { showingSubscriptionPaywall = true }
                }
            }
            
            Section(header: Text("Stay in touch", comment: "Section header in settings")) {
                Link(destination: URL(string: "https://itunes.apple.com/app/id1576390953?action=write-review")!) {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color(.systemRed))
                            .imageScale(.large)
                        
                        Text("Rate Simoleon", comment: "Button to rate app in Settings")
                    }
                }
                
                Link(destination: URL(string: "https://twitter.com/dennisconcep")!) {
                    HStack {
                        Image("TwitterLogo")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        Text("Developer's Twitter", comment: "Button to go to Twitter in Settings")
                    }
                }
                
                Link(destination: URL(string: "https://dennistech.io/contact")!) {
                    HStack {
                        Image(systemName: "envelope.circle.fill")
                            .renderingMode(.original)
                            .imageScale(.large)
                        
                        Text("Contact", comment: "Button to contact in Settings")
                    }
                }
            }
            
            Section(header: Text("About")) {
                Link(destination: URL(string: "https://dennistech.io")!) {
                    Text("Website", comment: "Button to go to Dennis Tech website")
                }
                
                Link(destination: URL(string: "https://dennistech.io/privacy-policy")!) {
                    Text("Privacy Policy", comment: "Button to go to app privacy policy")
                }
                
                Link(destination: URL(string: "https://dennistech.io/terms-of-use")!) {
                    Text("Terms of Use", comment: "Button to go to app terms of use")
                }
            }
        }
        .onAppear {
            checkEntitlement()
            /*
             if selectedDefaultCurrency is empty:
             * View is appearing for the first time
             * Set initial default curency for picker
             else:
             * View is appearing after user selected another default currency
             * Save it to core data
             */
            if selectedDefaultCurrency == "" {
                selectedDefaultCurrency = defaultCurrency.first?.pair ?? "USD/GBP"
            } else {
                setCoreData()
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("Settings", comment: "Navigation title"))
        .sheet(isPresented: $showingSubscriptionPaywall, onDismiss: checkEntitlement) {
            SubscriptionPaywall(showingSubscriptionPaywall: $showingSubscriptionPaywall)
        }
        .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
            NavigationView { content }
        }
    }
    
     
    // Save default currency to core data
    private func setCoreData() {
        if defaultCurrency.isEmpty {  // If it's empty -> add record
            let defaultCurrency = DefaultCurrency(context: viewContext)
            defaultCurrency.pair = selectedDefaultCurrency
            
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        } else {  // If not, update record
            defaultCurrency.first?.pair = selectedDefaultCurrency
            try? viewContext.save()
        }
    }
    
    // Check if user subscription is active
    private func checkEntitlement() {
        #if targetEnvironment(simulator)
        // We're in simulator
        entitlementIsActive = true
        #else
        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            if purchaserInfo?.entitlements["all"]?.isActive == true {
                entitlementIsActive = true
                print("Entitlement is active")
            } else {
                entitlementIsActive = false
                print("Entitlement is NOT active")
            }
        }
        #endif
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
