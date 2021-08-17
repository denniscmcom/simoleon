//
//  FavoriteButton.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/07/2021.
//

import SwiftUI

struct FavoriteButton: View {
    var currencyPair: String
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var favorites: FetchedResults<Favorite>
    
    @State private var starSymbol = "star"
    
    var body: some View {
        let favoriteCurrencyPairs = favorites.map { $0.currencyPair }
        Button(action: { favoriteAction(favoriteCurrencyPairs) }) {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(.secondarySystemBackground))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: generateStar(favoriteCurrencyPairs))
                        .font(.system(size: 28))
                        .foregroundColor(Color(.systemYellow))
                )
        }
        .accessibilityIdentifier("AddToFavorites")
    }
    
    /*
     If currency pair is favorite:
     * Button action is to remove from favorites
     else:
     * Button action is to add to favorites
     */
    private func favoriteAction(_ favoriteCurrencyPairs: [String]) {
        if favoriteCurrencyPairs.contains(currencyPair) {
            removeFromFavorites()
        } else {
            addToFavorites()
        }
        
        simpleSuccess()
    }
    
    /*
     if currency pair is favorite:
     * Return "star.fill" symbol
     else:
     * Return "star"
     */
    private func generateStar(_ favoriteCurrencyPairs: [String]) -> String {
        if favoriteCurrencyPairs.contains(currencyPair) {
            return "star.fill"
        } else {
            return "star"
        }
    }
    
    /*
     * Get first favorite core data object that matches the specified currency pair
     * Delete it
     */
    private func removeFromFavorites() {
        withAnimation {
            let favoriteObject = favorites.first(where: { $0.currencyPair == currencyPair })
            viewContext.delete(favoriteObject ?? Favorite())
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    /*
     * Create a favorite core data object
     * Save it
     */
    private func addToFavorites() {
        withAnimation {
            let favorite = Favorite(context: viewContext)
            favorite.currencyPair = currencyPair
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(currencyPair: "USD/GBP")
    }
}
