//
//  CurrencyConversionModel.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 21/12/21.
//

import Foundation

struct CurrencyConversionResponse: Codable {
    var message: [CurrencyConversionResult]
}

struct CurrencyConversionResult: Codable {
    var rate: Double
    var timestamp: Int
    var amount: Double
}
