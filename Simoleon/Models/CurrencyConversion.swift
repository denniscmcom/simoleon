//
//  CurrencyConversion.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 26/8/21.
//

import Foundation

class CurrencyConversion: ObservableObject {
    // Forex pair -> XXX/YYY where XXX = base symbol, YYY = quote symbol
    
    @Published var baseSymbol = "USD" {
        didSet {
            getQuote()
        }
    }
    @Published var quoteSymbol = "EUR" {
        didSet {
            getQuote()
        }
    }
    @Published var quote = CurrencyQuoteModel()
    @Published var isShowing = false
    @Published var showingAlert = false
    
    let networkHelper = NetworkHelper()
    
    init() {
        getQuote()
    }
    
    func getQuote() {
        self.isShowing = false
        let pair = "\(baseSymbol)/\(quoteSymbol)"
        let apiKey = readConfig(withKey: "API_KEY")!
        let url = "https://api.1forge.com/quotes?pairs=\(pair)&api_key=\(apiKey)"
        
        try? networkHelper.httpRequest(url: url, model: [CurrencyQuoteModel].self) { response in
            if let quote = response.first {
                self.quote = quote
            }
            
            self.isShowing = true
        }
    }
}
