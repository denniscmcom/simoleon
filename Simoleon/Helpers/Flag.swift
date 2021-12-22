//
//  Flag.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 20/12/21.
//

import SwiftUI

struct Flag: View {
    var flagName: String
    
    var body: some View {
        Image(flagName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 35, height: 35)
            .clipShape(Circle())
    }
}

struct Flag_Previews: PreviewProvider {
    static var previews: some View {
        Flag(flagName: "EU")
    }
}
