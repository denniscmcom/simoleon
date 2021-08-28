//
//  Flag.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 24/8/21.
//

import SwiftUI

struct Flag: View {
    var flag: String
    
    var body: some View {
        Image(flag)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 30, height: 30)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color(.secondaryLabel), lineWidth: 1))
    }
}

struct Flag_Previews: PreviewProvider {
    static var previews: some View {
        Flag(flag: "GB")
    }
}
