//
//  FavouriteButton.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/07/2021.
//

import SwiftUI

struct FavouriteButton: View {
    var currencyPair: String
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var favourite: FetchedResults<Favourite>
    
    var body: some View {
        Button(action: {
            if isFavourite() {
                removeFromFavourites()
                simpleSuccess()
            } else {
                addToFavourites()
                simpleSuccess()
            }
        }) {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color(.secondarySystemBackground))
                .frame(width: 65, height: 65)
                .overlay(
                    Image(systemName: generateStar())
                        .font(.system(size: 28))
                        .foregroundColor(Color(.systemYellow))
                        
                )
        }
    }
    
    private func isFavourite() -> Bool {
        let favouriteCurrencyPairs = favourite.map { $0.currencyPair }
        
        if favouriteCurrencyPairs.contains(currencyPair) {
            return true
        } else {
            return false
        }
    }
    
    private func generateStar() -> String {
        if isFavourite() {
            return "star.fill"
        } else {
            return "star"
        }
    }
    
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
