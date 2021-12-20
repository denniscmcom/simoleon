//
//  SupportedPairModel.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 8/12/21.
//

import Foundation

struct SupportedPairResponse: Codable {
    var pairs: [SupportedPairResult]
}

struct SupportedPairResult: Codable, Hashable {
    var fromCurrency: String
    var toCurrency: String
    var symbol: String
    var name: String
    var isCrypto: Int
}
