//
//  ContentView.swift
//  SimoleonWatchOS Extension
//
//  Created by Dennis Concepción Martín on 27/07/2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Favorite.currencyPair, ascending: true)],
        animation: .default) private var favorite: FetchedResults<Favorite>
    
    var body: some View {
        NavigationView {
            VStack {
                if favorite.isEmpty {
                    Group {
                        Image(systemName: "star")
                            .padding(.bottom, 5)
                            .font(.title2)
                        
                        Text("Add currencies to favorites on your iPhone.")
                            .multilineTextAlignment(.center)
                    }
                    .foregroundColor(.secondary)
                } else {
                    List {
                        ForEach(favorite) { favorite in
                            NavigationLink(destination: ConversionBox(currencyPair: favorite.currencyPair)) {
                                CurrencyRow(currencyPair: favorite.currencyPair)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Simoleon")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
