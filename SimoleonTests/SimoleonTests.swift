//
//  SimoleonTests.swift
//  SimoleonTests
//
//  Created by Dennis Concepción Martín on 8/12/21.
//

import XCTest
@testable import Simoleon

class SimoleonTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetBaseCurrencies() throws {
        let baseCurrency = SupportedCurrencyResult(code: "EUR", name: "Euro", isCrypto: 0)
        let quoteCurrency = SupportedCurrencyResult(code: "CHF", name: "Swiss Franc", isCrypto: 0)
        let currencyList = CurrencyList(
            baseCurrency: .constant(baseCurrency),
            quoteCurrency: .constant(quoteCurrency),
            selecting: .baseCurrency
        )
        
        let baseCurrencies = currencyList.getCurrencies()
        XCTAssertEqual(baseCurrencies.count, 5, "Base currencies does not match")
    }
    
    func testGetQuoteCurrencies() throws {
        let baseCurrency = SupportedCurrencyResult(code: "EUR", name: "Euro", isCrypto: 0)
        let quoteCurrency = SupportedCurrencyResult(code: "CHF", name: "Swiss Franc", isCrypto: 0)
        let currencyList = CurrencyList(
            baseCurrency: .constant(baseCurrency),
            quoteCurrency: .constant(quoteCurrency),
            selecting: .quoteCurrency
        )
        
        let quoteCurrencies = currencyList.getCurrencies()
        XCTAssertEqual(quoteCurrencies.count, 18, "Quote currencies does not match")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
