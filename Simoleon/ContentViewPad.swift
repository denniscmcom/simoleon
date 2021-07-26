//
//  ContentViewPad.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 18/07/2021.
//

import SwiftUI

struct ContentViewPad: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var defaultCurrency: FetchedResults<DefaultCurrency>
    
    var body: some View {
        NavigationView {
            Sidebar()
            Conversion(currencyPair: defaultCurrency.first?.pair ?? "USD/GBP")
        }
    }
}

struct ContentViewPad_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewPad()
    }
}
