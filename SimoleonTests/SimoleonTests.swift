//
//  SimoleonTests.swift
//  SimoleonTests
//
//  Created by Dennis Concepción Martín on 08/07/2021.
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
    
    func testReadJson() throws {
        let currencyPairs: [CurrencyPairModel]? = try? read(json: "CurrencyPairs.json")
        XCTAssertNotNil(currencyPairs)
        
        let currencyMetadata: [String: CurrencyMetadataModel]? = try? read(json: "CurrencyMetadata.json")
        XCTAssertNotNil(currencyMetadata)
    }
    
    func testFlagsExistence() throws {
        let currencyMetadata: [String: CurrencyMetadataModel]! = try! read(json: "CurrencyMetadata.json")
        
        for currencySymbol in currencyMetadata.keys {
            let flag = currencyMetadata[currencySymbol]!.flag
            XCTAssertTrue((UIImage(named: flag) != nil))
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
