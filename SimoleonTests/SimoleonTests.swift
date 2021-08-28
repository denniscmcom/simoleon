//
//  SimoleonTests.swift
//  SimoleonTests
//
//  Created by Dennis Concepción Martín on 27/8/21.
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
    
    func testGetAllCurrencies() throws {
        // Create test cases
        let testCases = [1: ["USD/GBP", "EUR/AED"], 2: ["USD/GBP", "USD/EUR"]]
        let expectedResults = [1: ["USD", "EUR"], 2: ["USD"]]
        
        // Test
        let currencySelector = CurrencySelector(currencyPair: CurrencyPairModel(baseSymbol: "USD", quoteSymbol: "EUR"))
        for testCaseNumber in testCases.keys {
            print("Testing case: \(testCaseNumber)")
            let mockData = testCases[testCaseNumber]!
            let allCurrencies = currencySelector.get(currencyType: .all, from: mockData)
            
            // Assert
            XCTAssertEqual(allCurrencies, expectedResults[testCaseNumber])
        }
    }
    
    func testGetCompatibleCurrencies() throws {
        // Create test cases
        let testCases = [1: ["USD/GBP", "EUR/AED"], 2: ["USD/GBP", "USD/EUR"], 3: ["EUR/AED"]]
        let expectedResults = [1: ["GBP"], 2: ["GBP", "EUR"], 3: []]
        
        // Test
        let currencySelector = CurrencySelector(currencyPair: CurrencyPairModel(baseSymbol: "USD", quoteSymbol: "EUR"))
        for testCaseNumber in testCases.keys {
            print("Testing case: \(testCaseNumber)")
            let mockData = testCases[testCaseNumber]!
            let compatibleCurrencies =
                currencySelector.get(
                    currencyType: .compatible(with: currencySelector.currencyPair.baseSymbol), from: mockData
                )
            
            // Assert
            XCTAssertEqual(compatibleCurrencies, expectedResults[testCaseNumber])
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
