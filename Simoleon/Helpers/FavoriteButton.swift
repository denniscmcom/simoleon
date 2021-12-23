//
//  FavoriteButton.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 21/12/21.
//

import SwiftUI
import CoreData

struct FavoriteButton: View {
    @Binding var baseCurrency: SupportedCurrencyResult
    @Binding var quoteCurrency: SupportedCurrencyResult
    @State private var scale: CGFloat = 1
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var favoritePairs: FetchedResults<FavoritePair>
    
    var body: some View {
        Button(action: {
            animate()
            if isFavorite() { remove() }
            else { add() }
        }) {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(.secondarySystemBackground))
                .frame(width: 60, height: 60)
                .overlay(
                    VStack {
                        if isFavorite() {
                            Image(systemName: "star.fill")
                        } else {
                            Image(systemName: "star")
                        }
                    }
                        .font(.system(size: 28))
                        .foregroundColor(Color(.systemYellow))
                )
        }
        .scaleEffect(scale)
        .animation(.linear(duration: 0.2), value: scale)
    }
    
    // Add currency conversion to favorites
    private func add() {
        let favoritePair = FavoritePair(context: viewContext)
        favoritePair.baseCurrency = baseCurrency.code
        favoritePair.quoteCurrency = quoteCurrency.code
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    // Remove currency conversion from favorites
    private func remove() {
        let favoritePair = favoritePairs.first(
            where: {
                $0.baseCurrency == baseCurrency.code && $0.quoteCurrency == quoteCurrency.code
        })
        
        viewContext.delete(favoritePair!)
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    // Check if currency conversion is in favorites
    private func isFavorite() -> Bool {
        let favoritePair = favoritePairs.first(
            where: {
                $0.baseCurrency == baseCurrency.code && $0.quoteCurrency == quoteCurrency.code
        })
        
        guard let _ = favoritePair else { return false }
        
        return true
    }
    
    // Animate favorite button 
    private func animate() {
        scale += 0.2
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            scale -= 0.2
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(
            baseCurrency: .constant(SupportedCurrencyResult(code: "EUR", name: "Euro", isCrypto: 0)),
            quoteCurrency: .constant(SupportedCurrencyResult(code: "USD", name: "U.S. Dollar", isCrypto: 0))
        )
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
