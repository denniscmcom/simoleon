//
//  SearchBar.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 11/07/2021.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        VStack {
            Capsule()
                .capsuleModifier(Color("Shadow"))
                
            Capsule()
                .capsuleModifier(Color(.systemBackground))
                .overlay(
                    ZStack(alignment: .leading) {
                        TextField("Search", text: $text)
                            .padding(.leading, 55)
                            .padding(.trailing)
                            .padding(.vertical, 25)  /// Expand tapable area
                            .onTapGesture { isEditing = true }
                            .contentShape(Capsule())
                        
                        Image(systemName: "magnifyingglass.circle")
                            .imageScale(.large)
                            .opacity(0.3)
                            .padding(.leading)
                    }
                )
                .offset(x: -4, y: -65)
                .padding(.bottom, -65)
        }
        .padding(.leading, 4)
        .padding(.horizontal)
        
    }
}
extension Capsule {
    func capsuleModifier(_ colour: Color) -> some View {
        self
            .strokeBorder(Color("Border"), lineWidth: 2)
            .background(Capsule().foregroundColor(colour))
            .frame(height: 50)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), isEditing: .constant(false))
    }
}
