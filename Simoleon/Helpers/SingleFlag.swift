//
//  SingleFlag.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 12/07/2021.
//

import SwiftUI

struct SingleFlag: View {
    var flag: String
    
    var body: some View {
        Image(flag)
            .flagModifier(50)
    }
}

struct SingleFlag_Previews: PreviewProvider {
    static var previews: some View {
        SingleFlag(flag: "EU")
    }
}
