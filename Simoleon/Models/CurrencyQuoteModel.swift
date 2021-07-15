//
//  CurrencyQuoteModel.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import SwiftUI

struct CurrencyQuoteModel: Codable, Hashable {
    var symbol: String?
    var price: Double?
    var bid: Double?
    var ask: Double?
    var timeStamp: Int?
    
    private enum CodingKeys: String, CodingKey {
        case symbol = "s"
        case price = "p"
        case bid = "b"
        case ask = "a"
        case timeStamp = "t"
    }
}
