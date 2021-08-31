//
//  FavoriteButton.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/07/2021.
//

import SwiftUI

struct FavoriteButton: View {
    @ObservedObject var currencyConversion: CurrencyConversion
    @State private var scale: CGFloat = 1
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var favoritePairs: FetchedResults<FavoritePair>
    
    let hapticsHelper = HapticsHelper()
    
    var body: some View {
        Button(action: {
            animate()
            if isFavorite() {
                remove()
            } else {
                add()
            }
            
            hapticsHelper.simpleSuccess()
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
    
    func add() {
        let favoritePair = FavoritePair(context: viewContext)
        favoritePair.baseSymbol = currencyConversion.baseSymbol
        favoritePair.quoteSymbol = currencyConversion.quoteSymbol
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func remove() {
        let favoritePair = favoritePairs.first(
            where: {
                $0.baseSymbol == currencyConversion.baseSymbol && $0.quoteSymbol == currencyConversion.quoteSymbol
        })
        
        viewContext.delete(favoritePair!)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func isFavorite() -> Bool {
        let favoritePair = favoritePairs.first(
            where: {
                $0.baseSymbol == currencyConversion.baseSymbol && $0.quoteSymbol == currencyConversion.quoteSymbol
        })
        
        guard let _ = favoritePair else { return false }
        
        return true
    }
    
    private func animate() {
        scale += 0.2
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            scale -= 0.2
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(currencyConversion: CurrencyConversion())
    }
}
