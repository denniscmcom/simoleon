//
//  FlagsPair.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 11/07/2021.
//

import SwiftUI

struct FlagsPair: View {
    var mainCurrencyFlag: String
    var secondaryCurrencyFlag: String
    
    var body: some View {
        ZStack {
            Image(secondaryCurrencyFlag)
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("FlagBorder"), lineWidth: 2))
            
            Image(mainCurrencyFlag)
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("FlagBorder"), lineWidth: 2))
                .offset(x: 35.0, y: 25.0)
        }
    }
}

struct FlagsPair_Previews: PreviewProvider {
    static var previews: some View {
        FlagsPair(mainCurrencyFlag: "GB", secondaryCurrencyFlag: "US")
            .frame(width: 100, height: 100)
    }
}
