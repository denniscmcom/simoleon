//
//  BigFlagsPair.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 11/07/2021.
//

import SwiftUI

struct BigFlagsPair: View {
    var mainCurrencyFlag: String
    var secondaryCurrencyFlag: String
    
    var body: some View {
        VStack {
            Image(secondaryCurrencyFlag)
                .flagModifier(80)
            
            Image(mainCurrencyFlag)
                .flagModifier(80)
                .offset(x: 40, y: -60)
                .padding(.bottom, -60)
                
                
        }
        .padding(.trailing, 40)
    }
}
extension Image {
    func flagModifier(_ size: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color("FlagBorder"), lineWidth: 2))
            .frame(width: size, height: size)
    }
}

struct FlagsPair_Previews: PreviewProvider {
    static var previews: some View {
        BigFlagsPair(mainCurrencyFlag: "GB", secondaryCurrencyFlag: "US")
    }
}
