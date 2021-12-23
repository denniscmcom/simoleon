//
//  FavoritesView.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 23/12/21.
//

import SwiftUI
import CoreData

struct FavoritesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoritePair.baseCurrency, ascending: true)], animation: .default
    ) private var favoritePairs: FetchedResults<FavoritePair>
    
    var body: some View {
        VStack {
            if favoritePairs.isEmpty {
                FavoritesPlaceholder()
            } else {
                List {
                    ForEach(favoritePairs, id:\.self) { favoritePair in
                        FavoriteRow(baseCurrency: favoritePair.baseCurrency!, quoteCurrency: favoritePair.quoteCurrency!)
                    }
                    .onDelete(perform: remove)
                }
            }
        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif
        }
        .navigationTitle("Favorites")
        .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
            NavigationView { content }
        }
    }
    
    // Remove favorite pair from favorites
    private func remove(offsets: IndexSet) {
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
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
