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
    var screnshotEndingName = ""

    override func setUpWithError() throws {
        // This method is called before the invocation of each test method in the class.
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIDevice.shared.orientation = .landscapeLeft
            screnshotEndingName = "-force_landscapeleft"
        }
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchScreenshot() throws {
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIApplication().tables["Sidebar"].buttons["NavigateToConversion"].tap()
        }
        
        sleep(2)
        snapshot("1Launch\(screnshotEndingName)")
    }
    
    func testConvertAmountScreenshot() throws {
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIApplication().tables["Sidebar"].buttons["NavigateToConversion"].tap()
        }
        
        let conversionTextField = XCUIApplication().textFields["ConversionTextField"]
        conversionTextField.tap()
        conversionTextField.typeText("1030.15\n")
        snapshot("2Conversion\(screnshotEndingName)")
    }
    
    func testCurrencySelectorScreenshot() throws {
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIApplication().tables["Sidebar"].buttons["NavigateToConversion"].tap()
        }
        
        XCUIApplication().scrollViews.buttons["OpenCurrencySelector"].tap()
        snapshot("3CurrencySelector\(screnshotEndingName)")
    }
    
    func testFavoriteScreenshot() throws {
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIApplication().tables["Sidebar"].buttons["NavigateToFavorites"].tap()
        } else {
            XCUIApplication().tabBars.buttons.element(boundBy: 1).tap()
        }
        
        sleep(1)
        
        snapshot("4Favorites\(screnshotEndingName)")
    }
}
