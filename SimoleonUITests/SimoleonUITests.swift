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
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIDevice.shared.orientation = .landscapeLeft
        }

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTabBar() throws {
        let app = XCUIApplication()
        app.launch()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            app.tables["Sidebar"].buttons["NavigateToConversion"].tap()
            XCTAssertTrue(app.staticTexts["Convert"].exists)
            
            app.tables["Sidebar"].buttons["NavigateToFavorites"].tap()
            XCTAssertTrue(app.staticTexts["Favorites"].exists)
            
            app.tables["Sidebar"].buttons["NavigateToSettings"].tap()
            XCTAssertTrue(app.staticTexts["Settings"].exists)
        } else {
            app.tabBars.buttons.element(boundBy: 0).tap()
            XCTAssertTrue(app.staticTexts["Convert"].exists)
            
            app.tabBars.buttons.element(boundBy: 1).tap()
            XCTAssertTrue(app.staticTexts["Favorites"].exists)
            
            app.tabBars.buttons.element(boundBy: 2).tap()
            XCTAssertTrue(app.staticTexts["Settings"].exists)
            
        }
    }
    
    func testCurrencySelector() throws {
        let app = XCUIApplication()
        app.launch()
        app.scrollViews.buttons["OpenCurrencySelector"].tap()
        
        let currencySearchBar = app.textFields["CurrencySearchBar"]
        currencySearchBar.tap()
        currencySearchBar.typeText("USD/BTC")
        app.tables.buttons["From USD to BTC"].tap()
    }
    
    func testCoreData() throws {
        let app = XCUIApplication()
        app.launch()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            app.tables["Sidebar"].buttons["NavigateToFavorites"].tap()
        } else {
            app.tabBars.buttons.element(boundBy: 1).tap()
        }
        
        XCTAssertTrue(app.tables.buttons["From USD to GBP"].exists)
        
        let favoriteList = app.tables
        favoriteList.buttons["From USD to GBP"].swipeLeft()
        favoriteList.buttons["Delete"].tap()
        XCTAssertFalse(app.tables.buttons["From USD to GBP"].exists)
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
