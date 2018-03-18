//
//  SegueTests.swift
//  StockQuoteUITests
//
//  Created by Thomas Ganley on 3/18/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest

class SegueTests: XCTestCase {
    
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app.launch()
    }
    
    func test_WhenTappingOnAppleStock_AppleDetailsAreLoaded() {
        app.tables.cells["AAPL, $177.90"].tap()
        let navBar = app.navigationBars.element(boundBy: 0)
        XCTAssertNotNil(navBar.staticTexts["AAPL"])
        
        let zeroLabel = app.staticTexts["0.00"]
        let doesntExist = NSPredicate(format: "exists == 0")
        
        let zeroExpectation = expectation(for: doesntExist, evaluatedWith: zeroLabel, handler: nil)
        wait(for: [zeroExpectation], timeout: 5)
    }
}
