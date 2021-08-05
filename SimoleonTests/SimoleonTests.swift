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
    
    func testMakeConversion() {
        // Given
        let testAmounts = ["iawuh", Int(100), Float(3450.30), Double(12530.43435)] as [Any]
        
        for var amountToConvert in testAmounts {
            // When
            if let amountToConvert = amountToConvert as? Double {
                // Then
                XCTAssertEqual(amountToConvert, amountToConvert, "Amount to convert is not returning correctly")
            } else {
                // Then
                amountToConvert = Int(0)
                XCTAssertEqual(amountToConvert as! Int, 0, "Amount to convert must be 0")
            }
        }
    }
    
    func testFormatCurrency() {
        // Given
        let availableIdentifiers = Locale.availableIdentifiers
        let amount: NSDecimalNumber = 1000
        
        for identifier in availableIdentifiers {
            let locale = Locale(identifier: identifier)
            
            let formatter = NumberFormatter()
            formatter.locale = locale
            formatter.numberStyle = .currency
            
            XCTAssertTrue((formatter.string(from: amount as NSNumber) != nil))
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
