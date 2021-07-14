//
//  FlagPair.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 11/07/2021.
//

import SwiftUI

struct FlagPair: View {
    var mainCurrencyFlag: String
    var secondaryCurrencyFlag: String
    
    var body: some View {
        VStack {
            Image(secondaryCurrencyFlag)
                .flagModifier(40)
            
            Image(mainCurrencyFlag)
                .flagModifier(40)
                .offset(x: 20, y: -40)
                .padding(.bottom, -40)
                
                
        }
        .padding(.trailing, 20)
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

struct SmallFlagsPair_Previews: PreviewProvider {
    static var previews: some View {
        FlagPair(mainCurrencyFlag: "GB", secondaryCurrencyFlag: "US")
    }
}
