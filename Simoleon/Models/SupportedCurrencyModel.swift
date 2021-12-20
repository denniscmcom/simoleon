//
//  SupportedCurrencyModel.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 8/12/21.
//

import Foundation

struct SupportedCurrencyResponse: Codable {
    var currencies: [SupportedCurrencyResult]
}

struct SupportedCurrencyResult: Codable, Hashable {
    var code: String
    var name: String
    var isCrypto: Int
}
