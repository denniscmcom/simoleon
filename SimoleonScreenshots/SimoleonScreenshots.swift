//
//  SimoleonScreenshots.swift
//  SimoleonScreenshots
//
//  Created by Dennis Concepción Martín on 5/8/21.
//

import XCTest

class SimoleonScreenshots: XCTestCase {
    var screnshotEndingName = ""

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIDevice.shared.orientation = .landscapeLeft
            screnshotEndingName = "-force_landscapeleft"
        }
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Automate screenshots
    func testLaunch() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIApplication().tables.buttons.firstMatch.tap()
        }
        
        snapshot("1Launch\(screnshotEndingName)")
    }
    
    func testCurrencySelector() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIApplication().tables.buttons.firstMatch.tap()
        }
        
        XCUIApplication().scrollViews.buttons.firstMatch.tap()
        snapshot("2CurrencySelector\(screnshotEndingName)")
        
        XCUIApplication().tables.buttons.element(boundBy: 6).tap()
        let conversionTextfield = XCUIApplication().textFields.firstMatch
        conversionTextfield.tap()
        for _ in (0..<4) {
            conversionTextfield.typeText(XCUIKeyboardKey.delete.rawValue)
        }
        
        conversionTextfield.typeText("\n")
        
        snapshot("3Amount\(screnshotEndingName)")
    }
    
    func testFavorites() throws {
        // Go to favorites
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCUIApplication().tables.buttons.element(boundBy: 1).tap()
        } else {
            XCUIApplication().tabBars.buttons.element(boundBy: 1).tap()
        }

        snapshot("4Favorites\(screnshotEndingName)")
    }
}
