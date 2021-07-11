//
//  SmallFlagsPair.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 11/07/2021.
//

import SwiftUI

struct SmallFlagsPair: View {
    var mainCurrencyFlag: String
    var secondaryCurrencyFlag: String
    
    var body: some View {
        VStack {
            Image(secondaryCurrencyFlag)
                .flagModifier(50)
            
            Image(mainCurrencyFlag)
                .flagModifier(50)
                .offset(x: 20, y: -40)
                .padding(.bottom, -40)
                
                
        }
        .padding(.trailing, 20)
    }
}

struct SmallFlagsPair_Previews: PreviewProvider {
    static var previews: some View {
        SmallFlagsPair(mainCurrencyFlag: "GB", secondaryCurrencyFlag: "US")
    }
}
