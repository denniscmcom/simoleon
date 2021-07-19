//
//  Favourites.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/07/2021.
//

import SwiftUI

struct Favourites: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Favourite.currencyPair, ascending: true)],
        animation: .default)
    private var favourite: FetchedResults<Favourite>
    
    var body: some View {
        List {
            ForEach(favourite) { favourite in
                CurrencyRow(currencyPair: favourite.currencyPair)
            }
            .onDelete(perform: removeFromFavourites)
        }
        .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
            NavigationView {
                content
                    .navigationTitle("Favourites")
                    .toolbar {
                        #if os(iOS)
                        EditButton()
                        #endif
                    }
            }
        }
    }
    
    private func removeFromFavourites(offsets: IndexSet) {
        withAnimation {
            offsets.map { favourite[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct Favourites_Previews: PreviewProvider {
    static var previews: some View {
        Favourites()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
