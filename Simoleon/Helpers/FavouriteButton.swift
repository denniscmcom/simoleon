//
//  FavouriteButton.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/07/2021.
//

import SwiftUI

struct FavouriteButton: View {
    var currencyPair: String
    
    @State private var starSymbol = "star"
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var favourite: FetchedResults<Favourite>
    
    var body: some View {
        let favouriteCurrencyPairs = favourite.map { $0.currencyPair }
        Button(action: { favouriteAction(favouriteCurrencyPairs) }) {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(.secondarySystemBackground))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: generateStar(favouriteCurrencyPairs))
                        .font(.system(size: 28))
                        .foregroundColor(Color(.systemYellow))
                )
        }
    }
    
    /*
     If currency pair is favourite -> button action is to remove from favourites
     else -> button action is to add to favourites
     */
    private func favouriteAction(_ favouriteCurrencyPairs: [String]) {
        if favouriteCurrencyPairs.contains(currencyPair) {
            removeFromFavourites()
        } else {
            addToFavourites()
        }
        
        simpleSuccess()
    }
    
    /*
     if currency pair is favourite -> return "star.fill" symbol
     else -> return "star"
     */
    private func generateStar(_ favouriteCurrencyPairs: [String]) -> String {
        if favouriteCurrencyPairs.contains(currencyPair) {
            return "star.fill"
        } else {
            return "star"
        }
    }
    
    /*
     1) Get first favourite core data object that matches the specified currency pair
     2) Delete it
     */
    private func removeFromFavourites() {
        withAnimation {
            let favouriteObject = favourite.first(where: { $0.currencyPair == currencyPair })
            viewContext.delete(favouriteObject ?? Favourite())
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    /*
     1) Create a favourite core data object
     2) Save it
     */
    private func addToFavourites() {
        withAnimation {
            let favourite = Favourite(context: viewContext)
            favourite.currencyPair = currencyPair
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct FavouriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteButton(currencyPair: "USD/GBP")
    }
}
