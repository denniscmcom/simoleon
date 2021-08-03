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
        animation: .default) private var favorite: FetchedResults<Favorite>
    
    var body: some View {
        VStack {
            if favorite.isEmpty {
                Group {
                    Image(systemName: "star")
                        .font(.title)
                    Text("Search a currency pair and add it to favourites.")
                        .padding(.top, 5)
                }
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 50)
            } else {
                List {
                    ForEach(favorite) { favorite in
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
            #if DEBUG
            generateFavoritesToScreenshots()
            #endif
        }
    }
    
    private func removeFromFavorites(offsets: IndexSet) {
        withAnimation {
            offsets.map { favorite[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    #if DEBUG
    private func generateFavoritesToScreenshots() {
        if favorite.isEmpty {
            let favoriteCurrencies = [
                "EUR/USD", "BTC/USD", "USD/HKD", "USD/JPY", "AUD/USD",
                "XAU/GBP", "DASH/ETH", "EUR/USD", "XAG/CAD"
            ]
            
            for favoriteCurrency in favoriteCurrencies {
                let favorite = Favorite(context: viewContext)
                favorite.currencyPair = favoriteCurrency
                
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
