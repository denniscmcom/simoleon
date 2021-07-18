//
//  ContentViewPad.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI

struct ContentViewPad: View {
    var body: some View {
        NavigationView {
            Sidebar()
            Conversion()
        }
    }
}

struct ContentViewPad_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewPad()
    }
}
