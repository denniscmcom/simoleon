//
//  Favorites.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/07/2021.
//

import SwiftUI

struct Favorites: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Favorite.currencyPair, ascending: true)],
        animation: .default) private var favorites: FetchedResults<Favorite>
    
    var body: some View {
        VStack {
            if favorites.isEmpty {
                Group {
                    Image(systemName: "star")
                        .font(.title)
                    
                    Text("Search a currency pair and add it to favorites.")
                        .padding(.top, 5)
                }
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 50)
            } else {
                List {
                    ForEach(favorites) { favorite in
                        NavigationLink(destination: Conversion(showNavigationView: false, currencyPair: favorite.currencyPair)) {
                            CurrencyRow(currencyPairName: favorite.currencyPair)
                        }
                    }
                    .onDelete(perform: removeFromFavorites)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Favorites")
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif
        }
        .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
            NavigationView { content }
        }
        .onAppear {
            #if SCREENSHOTS
            generateFavoritesForScreenshots()
            #endif
        }
    }
    
    private func removeFromFavorites(offsets: IndexSet) {
        withAnimation {
            offsets.map { favorites[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    #if SCREENSHOTS
    /*
     Save currencies to favourites to take screenshots for the App Store
     */
    private func generateFavoritesForScreenshots() {
        let favoriteCurrencies = [
            "EUR/USD", "BTC/USD", "USD/HKD", "USD/JPY", "AUD/USD",
            "XAU/GBP", "DASH/ETH", "EUR/USD", "XAG/CAD"
        ]
        
        let coreDataCurrencyPairs = favorites.map { $0.currencyPair }
        
        for favoriteCurrency in favoriteCurrencies {
            if !coreDataCurrencyPairs.contains(favoriteCurrency) {
                let favorites = Favorite(context: viewContext)
                favorites.currencyPair = favoriteCurrency
                
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
    #endif
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
