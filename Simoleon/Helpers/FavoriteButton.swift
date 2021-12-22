//
//  FavoriteButton.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 21/12/21.
//

import SwiftUI

struct FavoriteButton: View {
    @State private var scale: CGFloat = 1
    
    var body: some View {
        Button(action: {}) {
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
        
    }
    
    // Remove currency conversion from favorites
    private func remove() {
        
    }
    
    // Check if currency conversion is in favorites
    private func isFavorite() -> Bool {
        return false
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
        FavoriteButton()
    }
}
