//
//  SimoleonUITests.swift
//  SimoleonUITests
//
//  Created by Dennis Concepción Martín on 08/07/2021.
//

import XCTest

class SimoleonUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Automate screenshots
    func testLaunchScreenshots() {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        snapshot("0-Launch")

        // Remove 100 from conversion textfield and type custom amount
        let conversionTextfield = app.textFields["ConversionTextfield"]
        conversionTextfield.tap()
        for _ in (0..<4) {
            conversionTextfield.typeText(XCUIKeyboardKey.delete.rawValue)
        }
        conversionTextfield.typeText("1470.10")
        snapshot("1-Convert")

        // Remove custom amount and type again 1000
        for _ in (0..<7) {
            conversionTextfield.typeText(XCUIKeyboardKey.delete.rawValue)
        }
        conversionTextfield.typeText("1000\n")
    }
    
    func testCurrencySelectorScreenshots() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // Open currency selector, search BTC, and select first row
        app.buttons["CurrencySelector"].tap()
        snapshot("2-CurrencySelector")

        let searchBar = app.textFields["SearchBar"]
        searchBar.tap()
        searchBar.typeText("BTC")
        app.buttons["CurrencyRow"].firstMatch.tap()
        snapshot("3-Bitcoin")
    }
    
    func testFavorites() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        // Go to favorites
        app.tabBars.buttons.element(boundBy: 1).tap()
        snapshot("4-Favorites")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
