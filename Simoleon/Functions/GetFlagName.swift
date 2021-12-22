//
//  GetFlagName.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 20/12/21.
//

import Foundation

// Given currency code get flag name
func getFlagName(currency: SupportedCurrencyResult) -> String {
    guard currency.isCrypto == 0  else {
        return ""
    }
    
    let flagName = currency.code.dropLast()
    
    return String(flagName)
}
