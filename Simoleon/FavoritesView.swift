//
//  FavoritesView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/07/2021.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoritePair.baseSymbol, ascending: true)],
        animation: .default)
    private var favoritePairs: FetchedResults<FavoritePair>
    
    var body: some View {
        VStack {
            if favoritePairs.isEmpty {
                FavoritesPlaceholder()
            } else {
                List {
                    ForEach(favoritePairs, id:\.self) { favoritePair in
                        FavoritePairRow(favoritePair: favoritePair)
                            .padding(.vertical, 4)
                    }
                    .onDelete(perform: removeFromFavorites)
                }
                .listStyle(InsetGroupedListStyle())
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
            offsets.map { favoritePairs[$0] }.forEach(viewContext.delete)

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
        let pairs = ["EUR/USD", "BTC/USD", "USD/HKD", "USD/JPY", "AUD/USD",
                                  "XAU/GBP", "DASH/ETH", "EUR/USD", "XAG/CAD"]
        
        for pair in pairs {
            let symbols = pair.components(separatedBy: "/")
            let favoritePair = favoritePairs.first(
                where: {
                    $0.baseSymbol == symbols[0] && $0.quoteSymbol == symbols[1]
            })
            
            if let _ = favoritePair {
                // Do not save to core data again
            } else {
                let favoritePair = FavoritePair(context: viewContext)
                favoritePair.baseSymbol = symbols[0]
                favoritePair.quoteSymbol = symbols[1]
            }
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    #endif
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
