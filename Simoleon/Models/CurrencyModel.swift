//
//  CurrencyDetailsModel.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 23/8/21.
//

import Foundation

struct CurrencyModel: Codable {
    var symbol: String
    var name: String
    var flag: String
    var isCrypto: Bool
}
