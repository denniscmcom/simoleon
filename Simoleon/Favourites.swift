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
        VStack {
            if favourite.isEmpty {
                Group {
                    Text("Tap ", comment: "First line when favourites are empty") + Text(Image(systemName: "star"))
                    Text("to add a currency pair to favourites", comment: "Finish line when favourites are empty")
                        .padding(.top, 5)
                }
                .foregroundColor(Color(.systemGray))
            } else {
                List {
                    ForEach(favourite) { favourite in
                        NavigationLink(destination: Conversion(fetchUserSettings: false, currencyPair: favourite.currencyPair)) {
                            CurrencyRow(currencyPair: favourite.currencyPair)
                        }
                    }
                    .onDelete(perform: removeFromFavourites)
                }
            }
        }
        .navigationTitle(Text("Favourites", comment: "Navigation title"))
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif
        }
        .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
            NavigationView { content }
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
