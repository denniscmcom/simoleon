//
//  CurrencyConversionModel.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 21/12/21.
//

import Foundation

struct CurrencyLatestRateResponse: Codable {
    var message: [CurrencyLatestRateResult]
}

struct CurrencyLatestRateResult: Codable {
    var rate: Double
    var timestamp: Int
}
