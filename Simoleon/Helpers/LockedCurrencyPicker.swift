//
//  LockedCurrencyPicker.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 22/07/2021.
//

import SwiftUI

struct LockedCurrencyPicker: View {
    var body: some View {
        HStack {
            Text("Default currency")
            Spacer()
            Text("USD/GBP")
                .foregroundColor(Color(.systemGray))
            
            Image(systemName: "lock")
                .foregroundColor(Color(.systemGray))
        }
    }
}

struct LockedCurrencyPicker_Previews: PreviewProvider {
    static var previews: some View {
        LockedCurrencyPicker()
    }
}
