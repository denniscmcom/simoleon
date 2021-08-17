//
//  SimoleonScreenshots.swift
//  SimoleonScreenshots
//
//  Created by Dennis Concepción Martín on 5/8/21.
//

import XCTest
import CoreData
// Automate screenshots with Fastlane
class SimoleonScreenshots: XCTestCase {
    var screenshotEndingName = ""

    override func setUpWithError() throws {
        // This method is called before the invocation of each test method in the class.
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIDevice.shared.orientation = .landscapeLeft
            screenshotEndingName = "-force_landscapeleft"
        }

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchScreenshot() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            app.tables["Sidebar"].buttons["NavigateToConversion"].tap()
        }
        
        sleep(2)
        snapshot("1Launch\(screenshotEndingName)")
    }
    
    func testConvertAmountScreenshot() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            app.tables["Sidebar"].buttons["NavigateToConversion"].tap()
        }
        
        let conversionTextField = app.textFields["ConversionTextField"]
        conversionTextField.tap()
        conversionTextField.typeText("1030.15\n")
        snapshot("2Conversion\(screenshotEndingName)")
    }
    
    func testCurrencySelectorScreenshot() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            app.tables["Sidebar"].buttons["NavigateToConversion"].tap()
        }
        
        app.scrollViews.buttons["OpenCurrencySelector"].tap()
        snapshot("3CurrencySelector\(screenshotEndingName)")
    }
    
    func testFavoriteScreenshot() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            app.tables["Sidebar"].buttons["NavigateToFavorites"].tap()
        } else {
            app.tabBars.buttons.element(boundBy: 1).tap()
        }
        
        sleep(1)
        
        snapshot("4Favorites\(screenshotEndingName)")
    }
}
