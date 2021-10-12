//
//  CurrencyQuoteModel.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 15/07/2021.
//

import Foundation

struct CurrencyQuoteModel: Codable, Hashable {
    var pair: String?
    var price: Double?
    var bid: Double?
    var ask: Double?
    var timeStamp: Int?
    
    private enum CodingKeys: String, CodingKey {
        case pair = "s"
        case price = "p"
        case bid = "b"
        case ask = "a"
        case timeStamp = "t"
    }
}
