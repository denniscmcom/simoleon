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
                    Text("Tap ") + Text(Image(systemName: "star"))
                    Text("to add a currency pair to favorites")
                        .padding(.top, 5)
                }
                .foregroundColor(Color(.systemGray))
            } else {
                List {
                    ForEach(favorite) { favorite in
                        NavigationLink(destination: Conversion(showNavigationView: false, currencyPair: favorite.currencyPair)) {
                            CurrencyRow(currencyPair: favorite.currencyPair)
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
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
