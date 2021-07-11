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
        ZStack(alignment: .leading) {
            TextField("Search", text: $text)
                .padding(.leading, 50)
            
            Image(systemName: "magnifyingglass.circle")
                .padding(.leading)
                .imageScale(.large)
                .opacity(0.3)
            
        }
        .padding()
        .background(
            ZStack {
                Capsule()
                    .strokeBorder(Color("Border"), lineWidth: 2)
                    .background(Capsule().foregroundColor(Color("Bone")))
                    .offset(x: 7.0, y: 10.0)
                
                Capsule()
                    .strokeBorder(Color("Border"), lineWidth: 2)
                    .background(Capsule().foregroundColor(Color(.systemBackground)))
                
                
            }
        )
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), isEditing: .constant(false))
    }
}
