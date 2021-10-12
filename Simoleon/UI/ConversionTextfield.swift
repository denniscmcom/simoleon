//
//  ConversionTextfield.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 29/8/21.
//

import SwiftUI

struct ConversionTextfield: View {
    @Binding var amount: String
    @Binding var isEditing: Bool
    
    var body: some View {
        ZStack {
            TextField("Enter amount", text: $amount) { startedEditing in
                if startedEditing {
                    withAnimation {
                        isEditing = true
                    }
                }
            }
            onCommit: {
                withAnimation {
                    isEditing = false
                }
            }
            .keyboardType(.decimalPad)
            .font(Font.title.weight(.semibold))
            .lineLimit(1)
        }
    }
}

struct ConversionTextfield_Previews: PreviewProvider {
    static var previews: some View {
        ConversionTextfield(amount: .constant("1000"), isEditing: .constant(false))
    }
}
