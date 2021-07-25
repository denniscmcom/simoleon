//
//  Settings.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/07/2021.
//

import SwiftUI
import Purchases

struct Settings: View {
    @EnvironmentObject var subscriptionController: SubscriptionController
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var defaultCurrency: FetchedResults<DefaultCurrency>
    
    @State private var selectedDefaultCurrency = ""
    @State private var showingSubscriptionPaywall = false
    
    let currencyPairs: [String] = parseJson("CurrencyPairs.json")
    
    var body: some View {
        List {
            Section(header: Text("Subscription", comment: "Section header in settings")) {
                if subscriptionController.isActive {
                    NavigationLink(destination: SubscriberInfo()) {
                        Text("Information", comment: "Button to show subscription information in settings")
                    }
                } else {
                    Button(action: { showingSubscriptionPaywall = true }) {
                        Text("Subscribe", comment: "Button to suscribe in settings")
                    }
                }
            }
            
            Section(header: Text("Preferences", comment: "Section header in settings")) {
                if subscriptionController.isActive {
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
                
                Link(destination: URL(string: "https://dennistech.io")!) {
                    Text("Privacy Policy", comment: "Button to go to app privacy policy")
                }
                
                Link(destination: URL(string: "https://dennistech.io/terms-of-use")!) {
                    Text("Terms of Use", comment: "Button to go to app terms of use")
                }
            }
        }
        .onAppear(perform: onAppear)
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("Settings", comment: "Navigation title"))
        .sheet(isPresented: $showingSubscriptionPaywall) {
            Subscription(showingSubscriptionPaywall: $showingSubscriptionPaywall)
                .environmentObject(subscriptionController)
        }
        .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
            NavigationView { content }
        }
    }
    
    private func onAppear() {
        // Set initial value of the picker
        if selectedDefaultCurrency == "" {
            self.selectedDefaultCurrency = defaultCurrency.first?.pair ?? "USD/GBP"
        } else {
            setCoreData()
        }
    }
    
    private func setCoreData() {
        if self.defaultCurrency.isEmpty {  // If it's empty -> add record
            let defaultCurrency = DefaultCurrency(context: viewContext)
            defaultCurrency.pair = selectedDefaultCurrency
            
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        } else {  // If not, update record
            self.defaultCurrency.first?.pair = selectedDefaultCurrency
            try? viewContext.save()
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
            .environmentObject(SubscriptionController())
            .environment(\.locale, .init(identifier: "es"))
    }
}
