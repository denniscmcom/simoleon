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
            .frame(width: 35, height: 35)
            .clipShape(Circle())
    }
}

struct Flag_Previews: PreviewProvider {
    static var previews: some View {
        Flag(flag: "GB")
    }
}
