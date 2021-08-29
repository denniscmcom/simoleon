//
//  CurrencyPair.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 26/8/21.
//

import Foundation

class CurrencyPair: ObservableObject {
    /*
     Forex pair -> XXX/YYY
     Where XXX is the base currency, and YYY the quote currency
     */
    
    @Published var baseSymbol = "USD"
    @Published var quoteSymbol = "EUR"
}
