//
//  CurrencyBox.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 8/12/21.
//

import SwiftUI

struct CurrencyBox: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color(.secondarySystemBackground))
            .frame(height: 60)
            .overlay(
                HStack {
                    Image("FLAG_NAME")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                }
            )
    }
}

struct CurrencyBox_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyBox()
    }
}
