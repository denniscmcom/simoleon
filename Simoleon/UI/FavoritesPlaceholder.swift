//
//  FavoritesPlaceholder.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 5/9/21.
//

import SwiftUI

struct FavoritesPlaceholder: View {
    var body: some View {
        VStack {
            Group {
                Group {
                    Image(systemName: "star")
                        .padding(.bottom)
                    
                    Text("No Favorites")
                        .padding(.bottom, 5)
                }
                .font(.system(size: 30))
                
                Text("Your favorite currencies will appear here.")
            }
            .foregroundColor(.secondary)
        }
    }
}

struct FavoritesPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesPlaceholder()
    }
}
