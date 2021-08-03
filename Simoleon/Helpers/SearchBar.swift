//
//  SearchBar.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 27/07/2021.
//

import SwiftUI

struct SearchBar: View {
    var placeholder: LocalizedStringKey
    
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .disableAutocorrection(true)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(.tertiarySystemFill))
            )
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(placeholder: "Search ...", text: .constant(""))
    }
}
