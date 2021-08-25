//
//  SimoleonTests.swift
//  SimoleonTests
//
//  Created by Dennis Concepción Martín on 08/07/2021.
//

import XCTest
@testable import Simoleon

class SimoleonTests: XCTestCase {
    let fileController = FileController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testReadJson() throws {
        let currencyPairsSupported: [String]? = try? fileController.read(json: "CurrencyPairsSupported.json")
        XCTAssertNotNil(currencyPairsSupported, "An error occurred while reading CurrencyPairsSupported.json")
        
        let currencyDetails: [String: CurrencyDetailsModel]? = try? fileController.read(json: "CurrencyDetails.json")
        XCTAssertNotNil(currencyDetails, "An error occurred while reading CurrencyDetails.json")
    }
    
    func testCurrencyExistence() throws {
        let currencyDetails: [String: CurrencyDetailsModel] = try! fileController.read(json: "CurrencyDetails.json")
        
        // Remove duplicates from currency pairs supported
        let currencyPairsSupported: [String] = try! fileController.read(json: "CurrencyPairsSupported.json")
        var currenciesSupported = Set<String>()
        
        for currencyPairSupported in currencyPairsSupported {
            let symbols = currencyPairSupported.components(separatedBy: "/")
            for symbol in symbols {
                currenciesSupported.insert(symbol)
                XCTAssertNotNil(currencyDetails[symbol], "Currency details of symbol: \(symbol) can't be found")
                XCTAssertTrue((UIImage(named: currencyDetails[symbol]!.flag) != nil), "Flag of symbol: \(symbol) can't be found")
            }
        }
        
        // Check if there are same number of currencies
        XCTAssertEqual(currencyDetails.keys.count, currenciesSupported.count)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
