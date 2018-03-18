//
//  TableViewTests.swift
//  StockQuoteUITests
//
//  Created by Thomas Ganley on 3/18/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest

class TableViewTests: XCTestCase {
        
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app.launch()
    }
    
    func test_WhenTableViewLoaded_AllExpectedStocksAreLoaded() {
        let appleLabel = app.staticTexts["AAPL"]
        let microsoftLabel = app.staticTexts["MSFT"]
        let googleLabel = app.staticTexts["GOOG"]
        let nikeLabel = app.staticTexts["NKE"]
        let facebook = app.staticTexts["FB"]
        
        let exists = NSPredicate(format: "exists == 1")
        
        var expectations = [XCTestExpectation]()
        
        for label in [appleLabel, microsoftLabel, googleLabel, nikeLabel, facebook] {
            let labelExpectation = expectation(for: exists, evaluatedWith: label, handler: nil)
            expectations.append(labelExpectation)
        }
        
        wait(for: expectations, timeout: 5)
    }
}
