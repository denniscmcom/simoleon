//
//  GetCompatibleCurrencies.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 24/8/21.
//

import Foundation

class CurrenciesController {
    let fileController = FileController()
    
    func get(currenciesCompatibleWith currencySymbol: String?, currencies: Bool?) -> [String] {
        // If currencies not false -> return all currencies
        guard currencies == false else { return allCurrencies() }
        
        // This block won't be executed if the previous check fails
        return compatibleCurrencies(with: currencySymbol!)
    }
    
    /*
     * Input all currencies supported by vendor
     * Return individual currency symbols without duplicates
     */
    private func allCurrencies() -> [String] {
        let currencyPairsSupported: [String] = try! fileController.read(json: "CurrencyPairsSupported.json")
        
        var currencies = Set<String>()
        for currencyPairSupported in currencyPairsSupported {
            let currency = currencyPairSupported.components(separatedBy: "/")[0]
            currencies.insert(currency)
        }
        
        return Array(currencies)
    }
    
    /*
     * Given the first symbol of the currency pair
     * Return all compatible symbols
     */
    private func compatibleCurrencies(with currencySymbol: String) -> [String] {
        let currencyPairsSupported: [String] = try! fileController.read(json: "CurrencyPairsSupported.json")
        
        var currencies = [String]()
        for currencyPairSupported in currencyPairsSupported {
            if currencyPairSupported.hasPrefix(currencySymbol) {
                let compatibleCurrency = currencyPairSupported.components(separatedBy: "/")[1]
                currencies.append(compatibleCurrency)
            }
        }
        
        return currencies
    }
}
